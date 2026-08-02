using System;
using System.Data;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class ViewGroupDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadConcernGroups();
            }
        }

        private void LoadConcernGroups()
        {
            try
            {
                string connectionString =
                    System.Configuration.ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;

                string sql =
                    @"SELECT
                        concern_group_id,
                        concern_group_name,
                        concern_group_description,
                        status,
                        created_by,
                        created_at
                      FROM concern_groups
                      ORDER BY concern_group_id";

                using (MySqlConnection connection = new MySqlConnection(connectionString))
                {
                    using (MySqlCommand command = new MySqlCommand(sql, connection))
                    {
                        using (MySqlDataAdapter adapter = new MySqlDataAdapter(command))
                        {
                            DataTable groupTable = new DataTable();

                            adapter.Fill(groupTable);

                            gvGroups.DataSource = groupTable;
                            gvGroups.DataBind();

                            if (groupTable.Rows.Count == 0)
                            {
                                lblMessage.Text = "No concern groups are currently available.";
                            }
                            else
                            {
                                lblMessage.Text = "";
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