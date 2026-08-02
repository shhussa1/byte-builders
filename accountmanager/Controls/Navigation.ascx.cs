using System;

namespace accountmanager.Controls
{
    public partial class Navigation : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect(
                    ResolveUrl("~/Login.aspx")
                );

                return;
            }

            string firstName =
                Convert.ToString(
                    Session["FirstName"]
                ).Trim();

            string role =
                Convert.ToString(
                    Session["Role"]
                ).Trim();

            litUserName.Text =
                Server.HtmlEncode(firstName);

            litRole.Text =
                Server.HtmlEncode(role);

            SetMenuVisibility(role);
        }


        private void SetMenuVisibility(string role)
        {
            pnlEmployeeMenu.Visible = false;
            pnlManagerMenu.Visible = false;
            pnlAdminMenu.Visible = false;

            if (role.Equals(
                "Employee",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlEmployeeMenu.Visible = true;
                return;
            }

            if (role.Equals(
                "Manager",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlManagerMenu.Visible = true;
                return;
            }

            if (role.Equals(
                "Admin",
                StringComparison.OrdinalIgnoreCase))
            {
                pnlAdminMenu.Visible = true;
                return;
            }

            Session.Clear();
            Session.Abandon();

            Response.Redirect(
                ResolveUrl("~/Login.aspx")
            );
        }
    }
}