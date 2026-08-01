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
             * The dashboard requires a login.
             */
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            /*
             * The role must also exist.
             * If it does not, clear the invalid session.
             */
            if (Session["Role"] == null)
            {
                Session.Clear();

                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }


        private void LoadDashboard()
        {
            string firstName =
                Convert.ToString(
                    Session["FirstName"]
                );

            string role =
                Convert.ToString(
                    Session["Role"]
                );

            litUserName.Text =
                Server.HtmlEncode(firstName);

            litRole.Text =
                Server.HtmlEncode(role);

            SetMenuVisibility(role);
        }


        private void SetMenuVisibility(
            string role)
        {
            /*
             * Hide all role-specific panels first.
             */
            pnlEmployee.Visible = false;
            pnlManager.Visible = false;
            pnlAdmin.Visible = false;

            /*
             * Employee menu.
             */
            if (role.Equals(
                "Employee",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlEmployee.Visible = true;
                return;
            }

            /*
             * Manager menu.
             */
            if (role.Equals(
                "Manager",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlManager.Visible = true;
                return;
            }

            /*
             * Admin menu.
             */
            if (role.Equals(
                "Admin",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlAdmin.Visible = true;
                return;
            }

            /*
             * Unknown role:
             * clear the session and require login again.
             */
            Session.Clear();

            Response.Redirect("Login.aspx");
        }
    }
}