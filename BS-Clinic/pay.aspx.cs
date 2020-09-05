using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace BS_Clinic
{
    public partial class pay : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["admin"];
            HttpCookie cookie1 = HttpContext.Current.Request.Cookies["patient"];

            if (cookie != null)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("update pres set paid = 1 where id = " + Request.QueryString["p1"], con);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    stat.Controls.Add(new LiteralControl("<div class=\"alert alert-success text-center\" role=\"alert\">تم تسديد الفاتورة نقداً</div>"));
                }
                catch
                {
                    con.Close();
                }
            }
            else if (cookie1 == null)
            {
                Response.Redirect("~/Index.aspx");
            }
        }
        protected void sign_out(object sender, EventArgs e)
        {
            if (Request.Cookies["admin"] != null)
                Response.Cookies["admin"].Expires = DateTime.Now.AddDays(-1);
            if (Request.Cookies["patient"] != null)
                Response.Cookies["patient"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/Index.aspx");
        }
        int n(string s)
        {
            return Int32.Parse(s);
        }
        protected void btn_pay_Click(object sender, EventArgs e)
        {
            string card = tb_pay.Text;
            string pres = Request.QueryString["p1"];
            string amount;
            double price = 0;
            con.Open();
            SqlCommand cmd = new SqlCommand("select med_id from medices where pres_id = " + pres, con);
            DataTable dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            foreach (DataRow dr in dt.Rows)
            {
                string med = dr[0].ToString();
                cmd = new SqlCommand("select price from medication where id = " + med, con);
                price += Double.Parse(cmd.ExecuteScalar().ToString());
            }
            amount = price.ToString();
            cmd = new SqlCommand("select value from paycard where num = " + card, con);
            string value = "";
            try
            {
                value = cmd.ExecuteScalar().ToString();

                if (n(value) < n(amount))
                {
                    stat.Controls.Add(new LiteralControl("<div class=\"alert alert-warning text-center\" role=\"alert\">رصيد البطاقة غير كافي</div>"));
                    con.Close();
                    return;
                }
                int rem = n(value) - n(amount);
                cmd = new SqlCommand("update  pres set paid = 1 where id = " + pres, con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("update  paycard set value = " + rem + " where num = " + card, con);
                cmd.ExecuteNonQuery();

                con.Close();
                stat.Controls.Add(new LiteralControl("<div class=\"alert alert-success text-center\" role=\"alert\">تم تسديد المبلغ بنجاح</div>"));

            }
            catch
            {
                stat.Controls.Add(new LiteralControl("<div class=\"alert alert-danger text-center\" role=\"alert\">رقم البطاقة غير صالح</div>"));
            }
        }
    }
}