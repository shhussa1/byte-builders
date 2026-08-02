using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class ProposalStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
             * User must be logged in before viewing proposals.
             */
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProposals();
            }
        }


        private void LoadProposals()
        {
            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;

            /*
             * LEFT JOIN is intentional.
             *
             * Older proposals may not yet have a concern_group_id.
             * A LEFT JOIN keeps those proposals visible and displays
             * "Not assigned" for their concern group.
             */
            string sql =
                @"SELECT
                      p.proposal_id,
                      COALESCE(
                          cg.concern_group_name,
                          'Not assigned'
                      ) AS concern_group_name,
                      p.title,
                      p.description,
                      p.status
                  FROM proposals p
                  LEFT JOIN concern_groups cg
                      ON p.concern_group_id =
                         cg.concern_group_id
                  ORDER BY p.proposal_id DESC;";

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
                            DataTable proposalTable =
                                new DataTable();

                            adapter.Fill(proposalTable);

                            gvProposals.DataSource =
                                proposalTable;

                            gvProposals.DataBind();

                            if (proposalTable.Rows.Count == 0)
                            {
                                lblMessage.CssClass =
                                    "message proposal-status-message";

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
                lblMessage.CssClass =
                    "message message-error proposal-status-message";

                lblMessage.Text =
                    "Unable to load proposal status information.";
            }
        }


        /*
         * Returns a different CSS class depending on the
         * proposal status stored in the database.
         */
        protected string GetStatusCssClass(string status)
        {
            string normalizedStatus =
                Convert.ToString(status)
                    .Trim()
                    .ToLowerInvariant();

            switch (normalizedStatus)
            {
                case "submitted":
                    return "proposal-status-pill status-submitted";

                case "under review":
                    return "proposal-status-pill status-under-review";

                case "approved":
                    return "proposal-status-pill status-approved";

                case "implemented":
                    return "proposal-status-pill status-implemented";

                case "declined":
                case "rejected":
                    return "proposal-status-pill status-declined";

                default:
                    return "proposal-status-pill status-default";
            }
        }
    }
}