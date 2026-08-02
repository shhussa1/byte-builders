using System;
using System.Configuration;
using System.Data;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class ViewGroupDetails : System.Web.UI.Page
    {
        protected void Page_Load(
            object sender,
            EventArgs e)
        {
            /*
             * The user must first be logged in.
             */
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            /*
             * Only users with the Manager role may open
             * the View Concern Groups page.
             */
            string role =
                Convert.ToString(
                    Session["Role"]
                );

            if (!role.Equals(
                "Manager",
                StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }

            /*
             * Load concern groups only on the initial request.
             */
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

            /*
             * Join concern_groups with users so the page
             * displays the creator's name rather than the
             * numeric created_by user ID.
             *
             * LEFT JOIN is used so a concern group can still
             * appear even if its original user record is absent.
             */
            string sql =
                @"SELECT
                      cg.concern_group_id,
                      cg.concern_group_name,
                      cg.concern_group_description,
                      cg.status,

                      CASE
                          WHEN u.user_id IS NULL
                              THEN 'Unknown user'
                          ELSE CONCAT(
                              u.first_name,
                              ' ',
                              u.last_name
                          )
                      END AS created_by_name,

                      cg.created_at

                  FROM concern_groups AS cg

                  LEFT JOIN users AS u
                      ON cg.created_by = u.user_id

                  ORDER BY
                      cg.created_at DESC,
                      cg.concern_group_id DESC;";

            try
            {
                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    using (MySqlCommand command =
                        new MySqlCommand(sql, connection))
                    {
                        using (MySqlDataAdapter adapter =
                            new MySqlDataAdapter(command))
                        {
                            DataTable groupTable =
                                new DataTable();

                            adapter.Fill(groupTable);

                            gvGroups.DataSource =
                                groupTable;

                            gvGroups.DataBind();

                            if (groupTable.Rows.Count == 0)
                            {
                                lblMessage.CssClass =
                                    "message group-details-message";

                                lblMessage.Text =
                                    "No concern groups are currently available.";
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
                    "message message-error group-details-message";

                lblMessage.Text =
                    "Unable to load concern groups.";
            }
        }


        /*
         * Returns the correct theme class for the
         * concern-group status badge.
         */
        protected string GetGroupStatusClass(
            object statusValue)
        {
            string status =
                Convert.ToString(statusValue)
                    .Trim();

            if (status.Equals(
                "Active",
                StringComparison.OrdinalIgnoreCase))
            {
                return "group-status-active";
            }

            if (status.Equals(
                "Inactive",
                StringComparison.OrdinalIgnoreCase))
            {
                return "group-status-inactive";
            }

            if (status.Equals(
                "Pending",
                StringComparison.OrdinalIgnoreCase))
            {
                return "group-status-pending";
            }

            return "group-status-default";
        }


        /*
         * Formats the database date for display.
         */
        protected string FormatCreatedDate(
            object dateValue)
        {
            if (dateValue == null ||
                dateValue == DBNull.Value)
            {
                return "Not available";
            }

            DateTime createdDate;

            if (DateTime.TryParse(
                Convert.ToString(dateValue),
                out createdDate))
            {
                return createdDate.ToString(
                    "MMM d, yyyy"
                );
            }

            return Server.HtmlEncode(
                Convert.ToString(dateValue)
            );
        }
    }
}