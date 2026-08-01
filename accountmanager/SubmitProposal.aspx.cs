using System;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class SubmitProposal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmitProposal_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();

            if (string.IsNullOrWhiteSpace(title) ||
                string.IsNullOrWhiteSpace(description))
            {
                lblMessage.CssClass = "message message-error";
                lblMessage.Text = "Please enter a title and description.";
                return;
            }

            if (title.Length > 150)
            {
                lblMessage.CssClass = "message message-error";
                lblMessage.Text = "The proposal title cannot exceed 150 characters.";
                return;
            }

            if (description.Length > 500)
            {
                lblMessage.CssClass = "message message-error";
                lblMessage.Text = "The proposal description cannot exceed 500 characters.";
                return;
            }

            string connectionString =
                ConfigurationManager
                .ConnectionStrings["teamDB"]
                .ConnectionString;

            object submittedBy = DBNull.Value;

            if (Session["UserId"] != null)
            {
                int userId;

                if (int.TryParse(Session["UserId"].ToString(), out userId))
                {
                    submittedBy = userId;
                }
            }

            try
            {
                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    connection.Open();

                    string sql =
                        @"INSERT INTO proposals
                          (
                              title,
                              description,
                              status,
                              submitted_by
                          )
                          VALUES
                          (
                              @title,
                              @description,
                              'Submitted',
                              @submittedBy
                          );";

                    using (MySqlCommand command =
                        new MySqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue(
                            "@title",
                            title);

                        command.Parameters.AddWithValue(
                            "@description",
                            description);

                        command.Parameters.AddWithValue(
                            "@submittedBy",
                            submittedBy);

                        command.ExecuteNonQuery();
                    }
                }

                lblMessage.CssClass = "message message-success";
                lblMessage.Text = "Proposal submitted successfully.";

                txtTitle.Text = "";
                txtDescription.Text = "";
            }
            catch (Exception)
            {
                lblMessage.CssClass = "message message-error";
                lblMessage.Text = "Unable to submit the proposal.";
            }
        }
    }
}