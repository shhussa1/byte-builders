using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class SubmitConcernGroup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // User must be logged in.
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Only Manager or Admin can access this page.
            if (!UserCanCreateConcernGroup())
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }
        }


        protected void btnCreateConcernGroup_Click(
            object sender,
            EventArgs e)
        {
            // Check permission again before changing database data.
            if (!UserCanCreateConcernGroup())
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            string concernGroupName =
                txtConcernGroupName.Text.Trim();

            string concernGroupDescription =
                txtConcernGroupDescription.Text.Trim();


            if (string.IsNullOrWhiteSpace(concernGroupName) ||
                string.IsNullOrWhiteSpace(concernGroupDescription))
            {
                ShowError(
                    "Please enter the concern group name and description.");

                return;
            }


            if (concernGroupName.Length > 100)
            {
                ShowError(
                    "The concern group name cannot exceed 100 characters.");

                return;
            }


            if (concernGroupDescription.Length > 500)
            {
                ShowError(
                    "The description cannot exceed 500 characters.");

                return;
            }


            int createdBy;

            if (!int.TryParse(
                Convert.ToString(Session["UserId"]),
                out createdBy))
            {
                Session.Clear();
                Session.Abandon();

                Response.Redirect("Login.aspx");
                return;
            }


            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;


            try
            {
                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    connection.Open();


                    string duplicateSql =
                        @"SELECT COUNT(*)
                          FROM concern_groups
                          WHERE LOWER(concern_group_name) =
                                LOWER(@concernGroupName);";

                    using (MySqlCommand duplicateCommand =
                        new MySqlCommand(duplicateSql, connection))
                    {
                        duplicateCommand.Parameters.AddWithValue(
                            "@concernGroupName",
                            concernGroupName);

                        int duplicateCount =
                            Convert.ToInt32(
                                duplicateCommand.ExecuteScalar());

                        if (duplicateCount > 0)
                        {
                            ShowError(
                                "A concern group with this name already exists.");

                            return;
                        }
                    }


                    string insertSql =
                        @"INSERT INTO concern_groups
                          (
                              concern_group_name,
                              concern_group_description,
                              status,
                              created_by
                          )
                          VALUES
                          (
                              @concernGroupName,
                              @concernGroupDescription,
                              'Active',
                              @createdBy
                          );";


                    using (MySqlCommand insertCommand =
                        new MySqlCommand(insertSql, connection))
                    {
                        insertCommand.Parameters.AddWithValue(
                            "@concernGroupName",
                            concernGroupName);

                        insertCommand.Parameters.AddWithValue(
                            "@concernGroupDescription",
                            concernGroupDescription);

                        insertCommand.Parameters.AddWithValue(
                            "@createdBy",
                            createdBy);

                        insertCommand.ExecuteNonQuery();
                    }
                }


                lblMessage.CssClass =
                    "message message-success concern-message";

                lblMessage.Text =
                    "Concern group created successfully.";

                txtConcernGroupName.Text = "";
                txtConcernGroupDescription.Text = "";
            }
            catch (MySqlException ex)
            {
                if (ex.Number == 1062)
                {
                    ShowError(
                        "A concern group with this name already exists.");

                    return;
                }

                ShowError(
                    "Unable to create the concern group.");
            }
            catch (Exception)
            {
                ShowError(
                    "Unable to create the concern group.");
            }
        }


        private bool UserCanCreateConcernGroup()
        {
            if (Session["UserId"] == null ||
                Session["Role"] == null)
            {
                return false;
            }

            string role =
                Convert.ToString(Session["Role"]).Trim();

            bool isManager =
                role.Equals(
                    "Manager",
                    StringComparison.OrdinalIgnoreCase);

            bool isAdmin =
                role.Equals(
                    "Admin",
                    StringComparison.OrdinalIgnoreCase);

            return isManager || isAdmin;
        }


        private void ShowError(string message)
        {
            lblMessage.CssClass =
                "message message-error concern-message";

            lblMessage.Text = message;
        }
    }
}