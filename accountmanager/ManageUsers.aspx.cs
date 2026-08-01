using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(
            object sender,
            EventArgs e)
        {
            /*
             * A user must be logged in.
             */
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            /*
             * Only an Admin can access this page.
             */
            string currentRole =
                Convert.ToString(Session["Role"]);

            if (!currentRole.Equals(
                "Admin",
                StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            /*
             * Load the users only on the initial page request.
             * Do not reload before processing a button click.
             */
            if (!IsPostBack)
            {
                LoadUsers();
            }
        }


        private void LoadUsers()
        {
            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;

            /*
             * Admin accounts are deliberately excluded.
             * The page may manage only Employee and Manager roles.
             */
            string sql =
                @"SELECT
                      user_id,
                      CONCAT(first_name, ' ', last_name) AS full_name,
                      email,
                      role
                  FROM users
                  WHERE role IN ('Employee', 'Manager')
                  ORDER BY first_name, last_name;";

            try
            {
                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    connection.Open();

                    using (MySqlCommand command =
                        new MySqlCommand(sql, connection))
                    {
                        using (MySqlDataAdapter adapter =
                            new MySqlDataAdapter(command))
                        {
                            DataTable usersTable =
                                new DataTable();

                            adapter.Fill(usersTable);

                            gvUsers.DataSource = usersTable;
                            gvUsers.DataBind();
                        }
                    }
                }
            }
            catch (Exception)
            {
                ShowError("Unable to load the users.");
            }
        }


        protected void gvUsers_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {
            if (e.CommandName != "UpdateRole")
            {
                return;
            }

            /*
             * Verify the Admin role again because this operation
             * changes data.
             */
            if (Session["UserId"] == null ||
                !Convert.ToString(Session["Role"]).Equals(
                    "Admin",
                    StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int rowIndex;

            if (!int.TryParse(
                Convert.ToString(e.CommandArgument),
                out rowIndex))
            {
                ShowError(
                    "Unable to identify the selected user.");
                return;
            }

            if (rowIndex < 0 ||
                rowIndex >= gvUsers.Rows.Count)
            {
                ShowError(
                    "The selected user row is invalid.");
                return;
            }

            int userId;

            if (!int.TryParse(
                Convert.ToString(
                    gvUsers.DataKeys[rowIndex].Value),
                out userId))
            {
                ShowError(
                    "Unable to identify the selected user.");
                return;
            }

            GridViewRow selectedRow =
                gvUsers.Rows[rowIndex];

            DropDownList roleDropDown =
                selectedRow.FindControl("ddlRole")
                    as DropDownList;

            if (roleDropDown == null)
            {
                ShowError(
                    "Unable to read the selected role.");
                return;
            }

            string selectedRole =
                roleDropDown.SelectedValue;

            /*
             * Never accept an arbitrary role sent by the browser.
             */
            if (!IsAllowedRole(selectedRole))
            {
                ShowError("Invalid role selected.");
                return;
            }

            UpdateUserRole(userId, selectedRole);
        }


        private bool IsAllowedRole(string role)
        {
            return role.Equals(
                       "Employee",
                       StringComparison.OrdinalIgnoreCase)
                   ||
                   role.Equals(
                       "Manager",
                       StringComparison.OrdinalIgnoreCase);
        }


        private void UpdateUserRole(
            int userId,
            string selectedRole)
        {
            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;

            /*
             * The role restriction in the WHERE clause prevents
             * this page from changing an Admin account even if a
             * user ID is manually manipulated.
             */
            string sql =
                @"UPDATE users
                  SET role = @role
                  WHERE user_id = @userId
                    AND role IN ('Employee', 'Manager');";

            try
            {
                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    connection.Open();

                    using (MySqlCommand command =
                        new MySqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue(
                            "@role",
                            selectedRole);

                        command.Parameters.AddWithValue(
                            "@userId",
                            userId);

                        int rowsUpdated =
                            command.ExecuteNonQuery();

                        if (rowsUpdated == 0)
                        {
                            ShowError(
                                "The role was not updated. " +
                                "The user may no longer be eligible.");

                            LoadUsers();
                            return;
                        }
                    }
                }

                lblMessage.CssClass =
                    "message message-success management-message";

                lblMessage.Text =
                    "User role updated successfully.";

                LoadUsers();
            }
            catch (Exception)
            {
                ShowError(
                    "Unable to update the user role.");
            }
        }


        private void ShowError(string message)
        {
            lblMessage.CssClass =
                "message message-error management-message";

            lblMessage.Text = message;
        }
    }
}