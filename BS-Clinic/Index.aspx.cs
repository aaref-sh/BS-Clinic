using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BS_Clinic
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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