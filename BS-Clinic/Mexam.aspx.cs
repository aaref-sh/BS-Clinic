using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BS_Clinic
{
    public partial class Mexam : System.Web.UI.Page
    {

        static string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);
        protected int quan { get { return Int32.Parse(this.ViewState["quan"].ToString()); } set { this.ViewState["quan"] = value; } }
        protected string saved { get { return (string)this.ViewState["saved"]; } set { this.ViewState["saved"] = value; } }
        public string patient;
        public string ap;
        public int total = 0;
        public string[] times = { "08:00 ص", "08:30 ص", "09:00 ص", "09:30 ص", "10:00 ص", "10:30 ص", "11:00 ص", "11:30 ص", "12:00 م", "12:30م ", "01:00م ", "01:30 م", "02:00 م", "02:30 م", "03:00 م", "03:30 م", "04:00 م", "04:30 م", "05:00 م", "05:30 م" };
        int[] a = new int[50];
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["admin"];
            if (cookie == null) Response.Redirect("~/Index.aspx");
            if (!IsPostBack)
            {
                saved = "";
                for (int i = 0; i < 50; i++)a[i] = 0;
                ViewState["med"] = a;
                quan = 0;
                load();
            }
            else if (ViewState["med"] != null) a = ViewState["med"] as int[];
            
            ap = Request.QueryString["ap"];
            patient = get_data("select name from patient where id = (select patient_id from appointment where id = " + ap + ")").Rows[0][0].ToString();

            fill();
        }
        private DataTable get_data(string query)
        {
            DataTable dt = new DataTable();
            con.Open();
            SqlCommand cmd = new SqlCommand(query, con);
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        void load()
        {
            string query = "select id, name from medication";
            DataTable dl = get_data(query);
            List<ListItem> items = new List<ListItem>();
            items.Add(new ListItem("اختر دواء للإضافة", "0"));
            for (int i = 0; i < dl.Rows.Count; i++) items.Add(new ListItem(dl.Rows[i][1].ToString(), dl.Rows[i][0].ToString()));
            DropDownList1.DataValueField = "Value";
            DropDownList1.DataTextField = "Text";
            DropDownList1.DataSource = items;
            DropDownList1.DataBind();
        }
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            saved += DropDownList1.SelectedItem.Text + "<br>";

            a[quan] = Int32.Parse(DropDownList1.SelectedItem.Value);
            ViewState["med"] = a;
            
            quan++;
            DropDownList1.SelectedIndex = 0;
            fill();
        }
        protected void sign_out(object sender, EventArgs e)
        {
            if (Request.Cookies["admin"] != null)
                Response.Cookies["admin"].Expires = DateTime.Now.AddDays(-1);
            if (Request.Cookies["patient"] != null)
                Response.Cookies["patient"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/Index.aspx");
        }
        void fill()
        {
            medic.Controls.Clear();
            price.Controls.Clear();
            medic.Controls.Add(new LiteralControl("اسم الدواء <hr />"+saved));
            price.Controls.Add(new LiteralControl("السعر الإفرادي <hr />"));
            int p;
            total= 0;
            for (int i = 0; i < quan; i++)
            {
                p = Int32.Parse(get_data("select price from medication where id =" + a[i]).Rows[0][0].ToString());
                total += p;
                price.Controls.Add(new LiteralControl(p+"<br />"));
            }

        }
        void set_data(string query)
        {
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        protected void btn_set_Click(object sender, EventArgs eventArgs)
        {
            string query="select patient_id from appointment where id = "+ap;
            string p_id = get_data(query).Rows[0][0].ToString();
            query = "insert into pres (patient_id) values ("+p_id+")";
            set_data(query);
            query = "select max(id) from pres";
            string pres = get_data(query).Rows[0][0].ToString();
            for(int i = 0; i < quan; i++)
            {
                query = "insert into medices (pres_id, med_id) values ("+pres+","+a[i]+ ")";
                set_data(query);
            }
            query = "insert into mexam (patient_id , pres_id , [date] , [time] , res) values ("+p_id+" , "+pres+" , @date , "+((Int32.Parse(ap)-1)%20)+" , "+tb_bs.Text+")";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@date", DateTime.Now);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            query = "update appointment set patient_id = NULL where id = "+ap;
            set_data(query);
            tb_bs.Text = "";
            medic.Controls.Clear();
            price.Controls.Clear();
            total = 0;
            Response.Redirect("~/appointment.aspx?st=1");
        }
    }
}