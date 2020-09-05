using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BS_Clinic
{
    public partial class Login : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["admin"];
            HttpCookie cookie1 = HttpContext.Current.Request.Cookies["patient"];
            if (cookie != null || cookie1 != null) Response.Redirect("~/Appointment.aspx");
            if (!IsPostBack)
            {
                load();
            }
        }
        private void load()
        {
            List<ListItem> items = new List<ListItem>();
            items.Add(new ListItem("ذكر", "0"));
            items.Add(new ListItem("انثى", "1"));
            DropDownList1.DataValueField = "Value";
            DropDownList1.DataTextField = "Text";
            DropDownList1.DataSource = items;
            DropDownList1.DataBind();
        }

        public bool CheckUsername(string user_txt, string pass)
        {
            using (con)
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("select * from patient where [name] = N'" + user_txt +"' AND [pass] = N'" +pass+"'", con))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    
                    if (reader.HasRows)
                    {
                        con.Close();
                        return true;
                    }
                    con.Close();
                    return false;
                }
            }
        }
        protected void btn_sign_Click(object sender, EventArgs e)
        {
            string user = signuser.Text;
            string pass = signpass.Text;
            string repass = confirmpass.Text;
            if (signuser.Text.Length < 4)
            {
                signstat.Controls.Add(new LiteralControl("<div class=\"alert alert-primary text-center\" role=\"alert\">اسم المستخدم يجب أن يكون مكون من 4 أحرف على الأقل</div>"));
                return;
            }
            if (pass != repass || pass.Length < 4)
            {
                signstat.Controls.Add(new LiteralControl("<div class=\"alert alert-primary text-center\" role=\"alert\">كلمتي المرور قصار أو غير متطابقتين</div>"));
                return;
            }
            if(year.Text =="" || month.Text == "" || weight.Text == "")
            {
                signstat.Controls.Add(new LiteralControl("<div class=\"alert alert-primary text-center\" role=\"alert\">يرجى ملئ كافة الحقول</div>"));
                return;
            }
            if (CheckUsername(user,pass))
            {
                signstat.Controls.Add(new LiteralControl("<div class=\"alert alert-primary text-center\" role=\"alert\">يرجى استخدام اسم مستخدم آخر أو كلمة مرور أَخرى</div>"));
                return;
            }
            DateTime dt = DateTime.Parse("01/" + month.Text + "/" + year.Text);
            string g = DropDownList1.SelectedItem.Value;
            string query = "insert into patient ([name] , pass , birth , gender , weight) values (N'"+user+"' , N'"+pass+"' , @date , "+g +" , "+weight.Text+ " )";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@date", dt);
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                Response.Redirect("~/login.aspx");
            }
            catch(Exception ex) { Response.Write(ex.Message); }
        }
    }
}