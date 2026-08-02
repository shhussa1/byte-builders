using System;

namespace accountmanager
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Only logged-in users may open the dashboard.
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // The logged-in user's role must exist.
            if (Session["Role"] == null)
            {
                ClearSessionAndReturnToLogin();
                return;
            }

            string role =
                Convert.ToString(Session["Role"]).Trim();

            // Run this on every page request so the correct
            // role-based cards are always shown.
            SetMenuVisibility(role);
        }

        private void SetMenuVisibility(string role)
        {
            // Hide all role-specific sections first.
            pnlEmployee.Visible = false;
            pnlManager.Visible = false;
            pnlAdmin.Visible = false;

            if (role.Equals(
                "Employee",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlEmployee.Visible = true;
                return;
            }

            if (role.Equals(
                "Manager",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlManager.Visible = true;
                return;
            }

            if (role.Equals(
                "Admin",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlAdmin.Visible = true;
                return;
            }

            // Any unknown role is treated as an invalid session.
            ClearSessionAndReturnToLogin();
        }

        private void ClearSessionAndReturnToLogin()
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect("Login.aspx");
        }
    }
}