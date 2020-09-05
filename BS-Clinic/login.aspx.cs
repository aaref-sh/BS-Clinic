using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace BS_Clinic
{
    public partial class login : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["admin"];
            HttpCookie cookie1 = HttpContext.Current.Request.Cookies["patient"];
            if (cookie != null || cookie1 != null) Response.Redirect("~/Appointment.aspx");
        }

        private DataTable get_data(string query)
        {
            SqlCommand cmd = new SqlCommand(query, con);
            DataTable dt = new DataTable();
            con.Open();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
        protected void btn_login_Click(object sender, EventArgs e)
        {
            string user = loginuser.Text;
            string pass = loginpass.Text;
            string query = "select * from patient where [name] = N'" + user + "' and pass  = '" + pass + "'";
            string id = "";
            if(user == "admin" && pass == "admin")
            {
                HttpCookie cokie = new HttpCookie("admin");
                cokie.Expires = DateTime.Now.AddMonths(12);
                Response.Cookies.Add(cokie);
                Response.Redirect("~/Appointment.aspx");
            }
            try
            {
                id = get_data(query).Rows[0][0].ToString();
                HttpCookie cokie = new HttpCookie("patient");
                cokie["id"] = id;
                cokie.Expires = DateTime.Now.AddMonths(12);
                Response.Cookies.Add(cokie);
                Response.Redirect("~/Appointment.aspx");
            }

            catch
            {
                stat.Controls.Add(new LiteralControl("<div class=\"alert alert-primary text-center\" role=\"alert\">خطأ في اسم المستخدم أو كلمة المرور</div>"));
                return;
            }
            

        }
    }
}