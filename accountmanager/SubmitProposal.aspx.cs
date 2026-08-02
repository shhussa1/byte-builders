using System;
using System.Configuration;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class SubmitProposal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // User must be logged in.
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Only an Employee can submit a proposal.
            string role =
                Convert.ToString(Session["Role"]).Trim();

            if (!role.Equals(
                "Employee",
                StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            // Load the dropdown only when the page first opens.
            // Do not reload it after the Submit button is clicked.
            if (!IsPostBack)
            {
                LoadConcernGroups();
            }
        }


        private void LoadConcernGroups()
        {
            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;

            string sql =
                @"SELECT
                      concern_group_id,
                      concern_group_name
                  FROM concern_groups
                  WHERE status = 'Active'
                  ORDER BY concern_group_name;";

            try
            {
                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    connection.Open();

                    using (MySqlCommand command =
                        new MySqlCommand(sql, connection))
                    {
                        using (MySqlDataReader reader =
                            command.ExecuteReader())
                        {
                            ddlConcernGroup.DataSource = reader;

                            ddlConcernGroup.DataTextField =
                                "concern_group_name";

                            ddlConcernGroup.DataValueField =
                                "concern_group_id";

                            ddlConcernGroup.DataBind();
                        }
                    }
                }

                // Add the default option at the top.
                ddlConcernGroup.Items.Insert(
                    0,
                    new ListItem(
                        "Select a concern group",
                        ""
                    )
                );
            }
            catch (Exception)
            {
                ddlConcernGroup.Items.Clear();

                ddlConcernGroup.Items.Add(
                    new ListItem(
                        "Unable to load concern groups",
                        ""
                    )
                );

                ddlConcernGroup.Enabled = false;

                ShowError(
                    "Unable to load the available concern groups.");
            }
        }


        protected void btnSubmitProposal_Click(
            object sender,
            EventArgs e)
        {
            // Check login and role again before inserting data.
            if (!UserCanSubmitProposal())
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            int concernGroupId;

            if (!int.TryParse(
                ddlConcernGroup.SelectedValue,
                out concernGroupId))
            {
                ShowError(
                    "Please select a concern group.");

                return;
            }

            string title =
                txtTitle.Text.Trim();

            string description =
                txtDescription.Text.Trim();


            if (string.IsNullOrWhiteSpace(title) ||
                string.IsNullOrWhiteSpace(description))
            {
                ShowError(
                    "Please enter a title and description.");

                return;
            }


            if (title.Length > 150)
            {
                ShowError(
                    "The proposal title cannot exceed 150 characters.");

                return;
            }


            if (description.Length > 500)
            {
                ShowError(
                    "The proposal description cannot exceed 500 characters.");

                return;
            }


            int submittedBy;

            if (!int.TryParse(
                Convert.ToString(Session["UserId"]),
                out submittedBy))
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


                    // Confirm that the selected concern group
                    // still exists and is active.
                    string concernGroupSql =
                        @"SELECT COUNT(*)
                          FROM concern_groups
                          WHERE concern_group_id = @concernGroupId
                            AND status = 'Active';";

                    using (MySqlCommand concernGroupCommand =
                        new MySqlCommand(
                            concernGroupSql,
                            connection))
                    {
                        concernGroupCommand.Parameters.AddWithValue(
                            "@concernGroupId",
                            concernGroupId);

                        int activeGroupCount =
                            Convert.ToInt32(
                                concernGroupCommand.ExecuteScalar());

                        if (activeGroupCount == 0)
                        {
                            ShowError(
                                "The selected concern group is no longer available.");

                            LoadConcernGroups();
                            return;
                        }
                    }


                    string insertSql =
                        @"INSERT INTO proposals
                          (
                              concern_group_id,
                              title,
                              description,
                              status,
                              submitted_by
                          )
                          VALUES
                          (
                              @concernGroupId,
                              @title,
                              @description,
                              'Submitted',
                              @submittedBy
                          );";


                    using (MySqlCommand insertCommand =
                        new MySqlCommand(
                            insertSql,
                            connection))
                    {
                        insertCommand.Parameters.AddWithValue(
                            "@concernGroupId",
                            concernGroupId);

                        insertCommand.Parameters.AddWithValue(
                            "@title",
                            title);

                        insertCommand.Parameters.AddWithValue(
                            "@description",
                            description);

                        insertCommand.Parameters.AddWithValue(
                            "@submittedBy",
                            submittedBy);

                        insertCommand.ExecuteNonQuery();
                    }
                }


                lblMessage.CssClass =
                    "message message-success";

                lblMessage.Text =
                    "Proposal submitted successfully.";

                ddlConcernGroup.SelectedIndex = 0;
                txtTitle.Text = "";
                txtDescription.Text = "";
            }
            catch (Exception)
            {
                ShowError(
                    "Unable to submit the proposal.");
            }
        }


        private bool UserCanSubmitProposal()
        {
            if (Session["UserId"] == null ||
                Session["Role"] == null)
            {
                return false;
            }

            string role =
                Convert.ToString(Session["Role"]).Trim();

            return role.Equals(
                "Employee",
                StringComparison.OrdinalIgnoreCase);
        }


        private void ShowError(string message)
        {
            lblMessage.CssClass =
                "message message-error";

            lblMessage.Text = message;
        }
    }
}