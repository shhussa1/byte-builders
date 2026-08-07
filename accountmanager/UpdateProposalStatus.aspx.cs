using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class UpdateProposalStatus : System.Web.UI.Page
    {
        protected void Page_Load(
            object sender,
            EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string role =
                Convert.ToString(
                    Session["Role"]
                );

            bool allowed =
                role.Equals(
                    "Manager",
                    StringComparison.OrdinalIgnoreCase)
                ||
                role.Equals(
                    "Admin",
                    StringComparison.OrdinalIgnoreCase);

            if (!allowed)
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProposals();
            }
        }


        private void LoadProposals()
        {
            try
            {
                string connectionString =
                    ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;

                string sql =
                    @"SELECT
                          proposal_id,
                          title,
                          description,
                          status
                      FROM proposals
                      ORDER BY proposal_id DESC;";

                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    using (MySqlCommand command =
                        new MySqlCommand(sql, connection))
                    {
                        using (MySqlDataAdapter adapter =
                            new MySqlDataAdapter(command))
                        {
                            DataTable table =
                                new DataTable();

                            adapter.Fill(table);

                            gvProposals.DataSource =
                                table;

                            gvProposals.DataBind();

                            if (table.Rows.Count == 0)
                            {
                                lblMessage.CssClass =
                                    "message update-proposal-message";

                                lblMessage.Text =
                                    "No proposals are currently available.";
                            }
                            else
                            {
                                lblMessage.Text = "";
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                ShowError(
                    "Unable to load proposals."
                );
            }
        }


        protected void gvProposals_RowCommand(
            object sender,
            GridViewCommandEventArgs e)
        {
            if (e.CommandName != "UpdateProposalStatus")
            {
                return;
            }

            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string role =
                Convert.ToString(
                    Session["Role"]
                );

            bool allowed =
                role.Equals(
                    "Manager",
                    StringComparison.OrdinalIgnoreCase)
                ||
                role.Equals(
                    "Admin",
                    StringComparison.OrdinalIgnoreCase);

            if (!allowed)
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            int proposalId;

            if (!int.TryParse(
                Convert.ToString(
                    e.CommandArgument
                ),
                out proposalId))
            {
                ShowError(
                    "Unable to identify the proposal."
                );

                return;
            }

            Button updateButton =
                e.CommandSource as Button;

            if (updateButton == null)
            {
                ShowError(
                    "Unable to update the proposal."
                );

                return;
            }

            GridViewRow row =
                updateButton.NamingContainer
                as GridViewRow;

            if (row == null)
            {
                ShowError(
                    "Unable to identify the proposal row."
                );

                return;
            }

            DropDownList ddlStatus =
                row.FindControl("ddlStatus")
                as DropDownList;

            if (ddlStatus == null)
            {
                ShowError(
                    "Please select a proposal status."
                );

                return;
            }

            string newStatus =
                ddlStatus.SelectedValue;

            if (!IsValidStatus(newStatus))
            {
                ShowError(
                    "The selected proposal status is invalid."
                );

                return;
            }

            UpdateStatus(
                proposalId,
                newStatus
            );
        }


        private void UpdateStatus(
            int proposalId,
            string newStatus)
        {
            try
            {
                string connectionString =
                    ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;

                string sql =
                    @"UPDATE proposals
                      SET status = @status
                      WHERE proposal_id = @proposalId;";

                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    connection.Open();

                    using (MySqlCommand command =
                        new MySqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue(
                            "@status",
                            newStatus);

                        command.Parameters.AddWithValue(
                            "@proposalId",
                            proposalId);

                        int rowsAffected =
                            command.ExecuteNonQuery();

                        if (rowsAffected == 0)
                        {
                            ShowError(
                                "Proposal was not found."
                            );

                            return;
                        }
                    }
                }

                ShowSuccess(
                    "Proposal #" +
                    proposalId +
                    " was updated to " +
                    newStatus +
                    "."
                );

                LoadProposals();
            }
            catch (Exception)
            {
                ShowError(
                    "Unable to update proposal status."
                );
            }
        }


        private bool IsValidStatus(
            string status)
        {
            return
                status == "Submitted" ||
                status == "Under Review" ||
                status == "Approved" ||
                status == "Rejected" ||
                status == "Implemented";
        }


        protected string GetStatusClass(
            object statusValue)
        {
            string status =
                Convert.ToString(
                    statusValue
                ).Trim();

            if (status.Equals(
                "Submitted",
                StringComparison.OrdinalIgnoreCase))
            {
                return "proposal-status-submitted";
            }

            if (status.Equals(
                "Under Review",
                StringComparison.OrdinalIgnoreCase))
            {
                return "proposal-status-review";
            }

            if (status.Equals(
                "Approved",
                StringComparison.OrdinalIgnoreCase))
            {
                return "proposal-status-approved";
            }

            if (status.Equals(
                "Rejected",
                StringComparison.OrdinalIgnoreCase))
            {
                return "proposal-status-rejected";
            }

            if (status.Equals(
                "Implemented",
                StringComparison.OrdinalIgnoreCase))
            {
                return "proposal-status-implemented";
            }

            return "proposal-status-default";
        }


        private void ShowSuccess(
            string message)
        {
            lblMessage.CssClass =
                "message message-success update-proposal-message";

            lblMessage.Text =
                Server.HtmlEncode(message);
        }


        private void ShowError(
            string message)
        {
            lblMessage.CssClass =
                "message message-error update-proposal-message";

            lblMessage.Text =
                Server.HtmlEncode(message);
        }
    }
}