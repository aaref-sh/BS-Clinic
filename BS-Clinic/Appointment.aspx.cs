using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BS_Clinic
{
    public partial class Appointment : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);

        string[] times = { "08:00 ص", "08:30 ص", "09:00 ص", "09:30 ص", "10:00 ص", "10:30 ص", "11:00 ص", "11:30 ص", "12:00 م", "12:30م ", "01:00م ", "01:30 م", "02:00 م", "02:30 م", "03:00 م", "03:30 م", "04:00 م", "04:30 م", "05:00 م", "05:30 م" };
        int id = 1;
        public bool bol = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["admin"];
            HttpCookie cookie1 = HttpContext.Current.Request.Cookies["patient"];

            if (cookie1 != null)
            {
                id = Int32.Parse(cookie1["id"]);
                Fill();
                Old();
            }

            else if (cookie != null)
            {
                Fill_admin();
                Old_admin();
                bol = true;
            }

            else Response.Redirect("~/login.aspx");

            if (!IsPostBack) Load();
            string st = Request.QueryString["st"];
            if (st == "1") res.Controls.Add(new LiteralControl("<div class=\"alert alert-success alert-dismissible fade show\" role=\"alert\">تم تسجيل نتيجة الفحص بنجاح<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button></div>"));
        }

        protected void Delete_appointment(object sender, EventArgs e)
        {
            string query = "update appointment set patient_id = NULL where id =" + (sender as LinkButton).ID;
            Set_data(query);
            HttpCookie cookie = HttpContext.Current.Request.Cookies["admin"];
            if (cookie == null)
                Fill();
            else Fill_admin();
        }

        private DataTable Get_data(string query)
        {
            SqlCommand cmd = new SqlCommand(query, con);
            DataTable dt = new DataTable();
            con.Open();
            try
            {
                dt.Load(cmd.ExecuteReader());
            }
            catch { }
            con.Close();
            return dt;
        }

        private void Set_data(string query)
        {
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch { }
            con.Close();
        }

        protected void Book_appointment(object sender, EventArgs e)
        {
            string query = "update appointment set patient_id = " + id + " where id =" + (sender as LinkButton).ID;
            Set_data(query);
            Fill();
        }
        
        protected void Sign_out(object sender, EventArgs e)
        {
            if (Request.Cookies["admin"] != null)
                Response.Cookies["admin"].Expires = DateTime.Now.AddDays(-1);
            if (Request.Cookies["patient"] != null)
                Response.Cookies["patient"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/Index.aspx");
        }

        protected void Book_appointment_admin(object sender, EventArgs e)
        {
            string query = "update appointment set patient_id = " + DropDownList1.SelectedValue + " where id =" + (sender as LinkButton).ID;
            Set_data(query);
            Fill_admin();
        }

        private bool Ch(DataTable dt)
        {
            for (int i = 0; i < 120; i++) if (dt.Rows[i][1].ToString() == id.ToString()) return true;
            return false;
        }
        private new void Load()
        {
            string query = "select id, name from patient";
            DataTable dl = Get_data(query);
            List<ListItem> items = new List<ListItem>();
            items.Add(new ListItem("اختر مريض", "0"));
            for (int i = 0; i < dl.Rows.Count; i++) items.Add(new ListItem(dl.Rows[i][1].ToString(), dl.Rows[i][0].ToString())); ;
            DropDownList1.DataValueField = "Value";
            DropDownList1.DataTextField = "Text";
            DropDownList1.DataSource = items;
            DropDownList1.DataBind();
        }
    
        string Dr (DataTable dt)
        {
            return dt.Rows[0][0].ToString();
        }
        
        private void Old_admin()
        {
            string query = "select * from mexam";
            DataTable dt = Get_data(query);

            old.Controls.Clear();
            string[] lines = new string[dt.Rows.Count];
            for(int i = 0; i < dt.Rows.Count; i++)
            {
                lines[i] ="";
                string pres =  dt.Rows[i][2].ToString();
                string patient = Dr(Get_data("select name from patient where id = "+ dt.Rows[i][1].ToString()));
                lines[i] += "<tr><td>" + dt.Rows[i][0].ToString() + "</td>" ;
                lines[i] +="<td>" + patient + "</td>" ;
                lines[i] += "<td>" + Convert.ToDateTime(dt.Rows[i][3]).ToString("dd/MM/yyyy") + "</td>" ;
                lines[i] += "<td>" + times[Int32.Parse(dt.Rows[i][4].ToString())] + "</td>" ;
                lines[i] += "<td>" + dt.Rows[i][5].ToString() + "</td>" ;

                string btn = "<button type = \"button\" class=\"btn btn-link\" data-toggle=\"modal\" data-target=\"#exampl00" + i + "\">" + pres + "</button>";
                string cont = "";
                double price = 0;
                DataTable medices = Get_data("select * from medices where pres_id = " + pres);
                foreach(DataRow d in medices.Rows)
                {
                    double p = Double.Parse(Dr(Get_data("select price from medication where id = " + d[1].ToString())));
                    price += p;
                    cont += Dr(Get_data("select name from medication where id = " + d[1].ToString())) + "  -  " + p + "<br>";
                }

                cont += "<hr />الكلفة الاجمالية: " + price;
                string pay = "?p1="+ pres;
                string stat = "<br/><div class=\"alert alert-success\" role=\"alert\">هذه الفاتورة مسددة بالفعل</div>";
                if (!Convert.ToBoolean(Dr(Get_data("select paid from pres where id = " + pres))))
                    stat = "<br/><div class=\"alert alert-primary\" role=\"alert\">هذه الفاتورة غير مسددة <a href=\"pay.aspx"+pay+"\" class=\"alert-link\"> تعيينها كمسددة نقداً</a></div>";
                string div = "<div class=\"modal fade\" id=\"exampl00"+i+"\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"Title00"+i+"\" aria-hidden=\"true\"><div class=\"modal-dialog\" role=\"document\">";
                div += " <div class=\"modal-content\"><div class=\"modal-header\"><h5 class=\"modal-title tex\" id=\"Title00"+i+"\"> الوصفة رقم " + pres + " للمريض " + patient + "</h5>";
                div += " </div><div class=\"modal-body\" dir=\"rtl\">"+cont+stat+"</div><div class=\"modal-footer\"><button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">إغلاق</button>";
                div += " </div></div></div></div>";
                string btn_anal = "<td><a href=\"analyze.aspx?exm="+ dt.Rows[i][0].ToString() + "\" class=\"btn btn-warning\">تحليل</a></td>";

                lines[i] += "<td>" + btn + div + "</td>"+btn_anal+"</tr>";
            }

            for (int i = dt.Rows.Count - 1; i >= 0; i--) old.Controls.Add(new LiteralControl(lines[i]));
        }
        private void Old()
        {

            string query = "select * from mexam where patient_id =" + id;
            DataTable dt = Get_data(query);

            old.Controls.Clear();
            string[] lines = new string[dt.Rows.Count];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                lines[i] = "";
                string pres = dt.Rows[i][2].ToString();
                string patient = Dr(Get_data("select name from patient where id = " + dt.Rows[i][1].ToString()));
       
                lines[i] += "<tr><td>" + dt.Rows[i][0].ToString() + "</td>";
                lines[i] += "<td>" + patient + "</td>";
                lines[i] += "<td>" + Convert.ToDateTime(dt.Rows[i][3]).ToString("dd/MM/yyyy") + "</td>";
                lines[i] += "<td>" + times[Int32.Parse(dt.Rows[i][4].ToString())] + "</td>";
                lines[i] += "<td>" + dt.Rows[i][5].ToString() + "</td>";

    
                string btn = "<button type = \"button\" class=\"btn btn-link\" data-toggle=\"modal\" data-target=\"#exampl00" + i + "\">" + pres + "</button>";
                string cont = "";
                double price = 0;
                DataTable medices = Get_data("select * from medices where pres_id = " + pres);
                foreach (DataRow d in medices.Rows)
                {
                    double p = Double.Parse(Dr(Get_data("select price from medication where id = " + d[1].ToString())));
                    price += p;
                    cont += Dr(Get_data("select name from medication where id = " + d[1].ToString())) + "  -  " + p + "<br>";
                }
                cont += "<hr />الكلفة الاجمالية: " + price;
                string pay = "?p1=" + pres;
                string stat = "<br/><div class=\"alert alert-success\" role=\"alert\">هذه الفاتورة مسددة بالفعل</div>";
                if (!Convert.ToBoolean(Dr(Get_data("select paid from pres where id = " + pres))))
                    stat = "<br/><div class=\"alert alert-primary\" role=\"alert\">هذه الفاتورة غير مسددة <a href=\"pay.aspx" + pay + "\" class=\"alert-link\"> تسديد الآن</a></div>";
                string div = "<div class=\"modal fade\" id=\"exampl00" + i + "\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"Title00" + i + "\" aria-hidden=\"true\"><div class=\"modal-dialog\" role=\"document\">";
                div += " <div class=\"modal-content\"><div class=\"modal-header\"><h5 class=\"modal-title tex\" id=\"Title00" + i + "\"> الوصفة رقم " + pres + " للمريض " + patient + "</h5>";
                div += " </div><div class=\"modal-body\" dir=\"rtl\">" + cont + stat + "</div><div class=\"modal-footer\"><button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">إغلاق</button>";
                div += " </div></div></div></div>";
                string btn_anal = "<td><a href=\"analyze.aspx?exm=" + dt.Rows[i][0].ToString() + "\" class=\"btn btn-warning\">تحليل</a></td>";

                lines[i] += "<td>" + btn + div + "</td>" + btn_anal + "</tr>";
            }

            for (int i = dt.Rows.Count - 1; i >= 0; i--) old.Controls.Add(new LiteralControl(lines[i]));
        }
        private void Fill()
        {
            string query = "select * from appointment";
            DataTable dt = Get_data(query);
            int td = 0;
            td = (int)DateTime.Now.DayOfWeek;
            td++;
            if (td == 7) td = 0;
            bdy.Controls.Clear();
            bool toolate = false;
            bool b = Ch(dt);
            for (int i = 0; i < 20; i++)
            {
                bdy.Controls.Add(new LiteralControl("<tr> <th scope = \"row\" >" + times[i] + "</ th > "));
                for (int j = 0; j < 6; j++)
                {
                    string ap_id = dt.Rows[20 * j + i][1].ToString();
                    if (ap_id == id.ToString())
                    {
                        LinkButton lb1 = new LinkButton();
                        lb1.ID = "" + (20 * j + i + 1);
                        lb1.Text = "حذف";
                        lb1.CssClass = "btn btn-danger btn-sm";
                        lb1.Click += new EventHandler(Delete_appointment);
                        lb1.Attributes.Add("data-toggle", "tooltip");
                        lb1.Attributes.Add("data-placement", "right");
                        lb1.Attributes.Add("title", "إلغاء حجز هذا الموعد");
                        bdy.Controls.Add(new LiteralControl("<td>"));
                        bdy.Controls.Add(lb1);
                        bdy.Controls.Add(new LiteralControl("</td>"));
                        UpdatePanel1.Triggers.Add(new AsyncPostBackTrigger() { ControlID = lb1.UniqueID, EventName = "Click" });
                    }
                    else if (ap_id == "")
                    {
                        LinkButton lb1 = new LinkButton();
                        lb1.ID = "" + (20 * j + i + 1);
                        lb1.Text = "حجز";
                        lb1.CssClass = "btn btn-primary btn-sm";
                        lb1.Click += new EventHandler( Book_appointment);
                        lb1.Attributes.Add("data-toggle", "tooltip");
                        lb1.Attributes.Add("data-placement", "right");
                        lb1.Attributes.Add("title", "حجز هذا الموعد");
                        if (td > j) toolate = true;
                        else if(td==j) {
                            toolate = false;
                            if (Convert.ToDateTime(times[i]) < DateTime.Now)
                                toolate = true;
                        }
                        else toolate = false;
                        if (b || toolate) lb1.CssClass = "btn btn-primary btn-sm disabled";
                        bdy.Controls.Add(new LiteralControl("<td>"));
                        bdy.Controls.Add(lb1);
                        bdy.Controls.Add(new LiteralControl("</td>"));
                        UpdatePanel1.Triggers.Add(new AsyncPostBackTrigger() { ControlID = lb1.UniqueID, EventName = "Click" });
                    }
                    else
                    {
                        LinkButton lb1 = new LinkButton();
                        lb1.ID = "" + (20 * j + i + 1);
                        lb1.Text = "محجوز";
                        lb1.CssClass = "btn btn-secondary btn-sm disabled";
                        lb1.Attributes.Add("data-toggle", "tooltip");
                        lb1.Attributes.Add("data-placement", "right");
                        bdy.Controls.Add(new LiteralControl("<td>"));
                        bdy.Controls.Add(lb1);
                        bdy.Controls.Add(new LiteralControl("</td>"));
                    }
                }
                bdy.Controls.Add(new LiteralControl("</ tr>"));
            }
        }
        private void Fill_admin()
        {
            string query = "select * from appointment";
            DataTable dt = Get_data(query);


            int td = 0;
            td = (int)DateTime.Now.DayOfWeek;
            td++;
            if (td == 7) td = 0;
            bool toolate = false;
            bdy.Controls.Clear();
            set.Controls.Clear();
            for (int i = 0; i < 20; i++)
            {
                bdy.Controls.Add(new LiteralControl("<tr> <th scope = \"row\" >" + times[i] + "</ th > "));
                set.Controls.Add(new LiteralControl("<tr> <th scope = \"row\" >" + times[i] + "</ th > "));
                for (int j = 0; j < 6; j++)
                {
                    string ap_id = dt.Rows[20 * j + i][1].ToString();
             
                    if (ap_id != "")
                    {
                        LinkButton lb1 = new LinkButton();
                        lb1.ID = "" + (20 * j + i + 1);
                        lb1.Text = "حذف";
                        lb1.CssClass = "btn btn-danger btn-sm";
                        lb1.Click += new EventHandler(Delete_appointment);
                        lb1.Attributes.Add("data-toggle", "tooltip");
                        lb1.Attributes.Add("data-placement", "right");
                        lb1.Attributes.Add("title", "هذا الموعد محجوز لـ" + Get_data("select name from patient where id =" + ap_id).Rows[0][0].ToString());
                        bdy.Controls.Add(new LiteralControl("<td>"));
                        bdy.Controls.Add(lb1);
                        bdy.Controls.Add(new LiteralControl("</td>"));
                        UpdatePanel1.Triggers.Add(new AsyncPostBackTrigger() { ControlID = lb1.UniqueID, EventName = "Click" });
           
                        string set_to = "?ap=" + (20 * j + i + 1);
                        set.Controls.Add(new LiteralControl("<td><a href=\"Mexam.aspx" +set_to+ "\" data-toggle=\"tooltip\" data-placement=\"right\" title=\"تحديد نتيجة هذا الفحص\" class=\"alert-link\"> إنهاء</a></td>"));
                    }
                    else
                    {
                        LinkButton lb1 = new LinkButton();
                        lb1.ID = "" + (20 * j + i + 1);
                        lb1.Text = "حجز هنا";
                        lb1.CssClass = "btn btn-primary btn-sm";
                        lb1.Attributes.Add("data-toggle", "tooltip");
                        lb1.Attributes.Add("data-placement", "right");
                        lb1.Attributes.Add("title", "اختر مريض من القائمة على اليمين لحجز هذا الموعد له");
                        if (td > j) toolate = true;
                        else if (td == j)
                        {
                            toolate = false;
                            if (Convert.ToDateTime(times[i]) < DateTime.Now)
                                toolate = true;
                        }
                        else toolate = false;
                        if (toolate) lb1.CssClass = "btn btn-primary btn-sm disabled";
                        lb1.Click += new EventHandler(Book_appointment_admin);
                        bdy.Controls.Add(new LiteralControl("<td>"));
                        bdy.Controls.Add(lb1);
                        bdy.Controls.Add(new LiteralControl("</td>"));
                        UpdatePanel1.Triggers.Add(new AsyncPostBackTrigger() { ControlID = lb1.UniqueID, EventName = "Click" });
        
                        set.Controls.Add(new LiteralControl("<td>لا يوجد</td>"));
                    }
                }
                bdy.Controls.Add(new LiteralControl("</ tr>"));
                set.Controls.Add(new LiteralControl("</ tr>"));
            }
        }
        protected void Btn_clear_Click(object sender, EventArgs e)
        {
            Set_data("update appointment set patient_id = NULL");
            Fill_admin();
        }
    }
}