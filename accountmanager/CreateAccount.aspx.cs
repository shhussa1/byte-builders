using System;
using System.Security.Cryptography;
using System.Text;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class CreateAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim().ToLower();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (firstName == "" ||
                lastName == "" ||
                email == "" ||
                password == "" ||
                confirmPassword == "")
            {
                lblMessage.Text = "Please complete all fields.";
                return;
            }

            if (password != confirmPassword)
            {
                lblMessage.Text = "Passwords do not match.";
                return;
            }

            string connectionString =
                System.Configuration.ConfigurationManager
                .ConnectionStrings["teamDB"]
                .ConnectionString;

            try
            {
                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    connection.Open();

                    string checkSql =
                        "SELECT COUNT(*) FROM users WHERE email = @email";

                    using (MySqlCommand checkCommand =
                        new MySqlCommand(checkSql, connection))
                    {
                        checkCommand.Parameters.AddWithValue("@email", email);

                        int count =
                            Convert.ToInt32(checkCommand.ExecuteScalar());

                        if (count > 0)
                        {
                            lblMessage.Text =
                                "An account with this email already exists.";
                            return;
                        }
                    }

                    string passwordHash = HashPassword(password);

                    string insertSql =
                        @"INSERT INTO users
                          (first_name, last_name, email, password_hash, role)
                          VALUES
                          (@firstName, @lastName, @email, @passwordHash, 'Employee')";

                    using (MySqlCommand insertCommand =
                        new MySqlCommand(insertSql, connection))
                    {
                        insertCommand.Parameters.AddWithValue(
                            "@firstName", firstName);

                        insertCommand.Parameters.AddWithValue(
                            "@lastName", lastName);

                        insertCommand.Parameters.AddWithValue(
                            "@email", email);

                        insertCommand.Parameters.AddWithValue(
                            "@passwordHash", passwordHash);

                        insertCommand.ExecuteNonQuery();
                    }

                    lblMessage.Text =
                        "Account created successfully.";
                }
            }
            catch (Exception)
            {
                lblMessage.Text =
                    "Unable to create account.";
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes =
                    sha256.ComputeHash(
                        Encoding.UTF8.GetBytes(password));

                StringBuilder builder =
                    new StringBuilder();

                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }

                return builder.ToString();
            }
        }
    }
}