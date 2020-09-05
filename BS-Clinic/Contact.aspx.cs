using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BS_Clinic
{
    public partial class Contact : System.Web.UI.Page
    {
        public bool b = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["admin"];
            HttpCookie cookie1 = HttpContext.Current.Request.Cookies["patient"];

            if (cookie1 != null || cookie != null) b = true;
        }
        protected void sign_out(object sender, EventArgs e)
        {
            if (Request.Cookies["admin"] != null)
                Response.Cookies["admin"].Expires = DateTime.Now.AddDays(-1);
            if (Request.Cookies["patient"] != null)
                Response.Cookies["patient"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/Index.aspx");
        }
    }
}