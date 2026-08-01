using System;

namespace accountmanager
{
    public partial class Logout :
        System.Web.UI.Page
    {
        protected void Page_Load(
            object sender,
            EventArgs e)
        {
            /*
             * Remove all session information.
             */
            Session.Clear();
            Session.Abandon();

            /*
             * Return the user to Login.
             */
            Response.Redirect("Login.aspx");
        }
    }
}