using System;

namespace accountmanager
{
    public partial class Dashboard :
        System.Web.UI.Page
    {
        protected void Page_Load(
            object sender,
            EventArgs e)
        {
            /*
             * Only logged-in users can open the dashboard.
             */
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            /*
             * The user's role must exist in the session.
             */
            if (Session["Role"] == null)
            {
                Session.Clear();
                Session.Abandon();

                Response.Redirect("Login.aspx");
                return;
            }

            /*
             * Set visibility every time the page loads.
             * This ensures the correct role menu is displayed.
             */
            string role =
                Convert.ToString(
                    Session["Role"]
                ).Trim();

            SetMenuVisibility(role);
        }


        private void SetMenuVisibility(
            string role)
        {
            /*
             * Hide every role-specific panel first.
             */
            pnlEmployee.Visible = false;
            pnlManager.Visible = false;
            pnlAdmin.Visible = false;


            /*
             * Employee dashboard.
             */
            if (role.Equals(
                "Employee",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlEmployee.Visible = true;
                return;
            }


            /*
             * Manager dashboard.
             */
            if (role.Equals(
                "Manager",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlManager.Visible = true;
                return;
            }


            /*
             * Admin dashboard.
             */
            if (role.Equals(
                "Admin",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlAdmin.Visible = true;
                return;
            }


            /*
             * Unknown role.
             */
            Session.Clear();
            Session.Abandon();

            Response.Redirect("Login.aspx");
        }
    }
}