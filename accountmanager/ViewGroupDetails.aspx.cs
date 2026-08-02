using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class ProposalStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                    System.Configuration.ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;

                string sql =
                    @"SELECT proposal_id,
                             title,
                             description,
                             status
                      FROM proposals
                      ORDER BY proposal_id";

                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
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
                                lblMessage.Text =
                                    "No proposals are currently available.";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "ERROR: " + ex.Message;
            }
        }
    }
}