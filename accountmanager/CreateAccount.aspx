<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="CreateAccount.aspx.cs"
    Inherits="accountmanager.CreateAccount" %>

<!DOCTYPE html>

<html>

<head runat="server">

    <title>Create Account | Byte Builders</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1" />

    <link href="Styles/site.css"
          rel="stylesheet"
          type="text/css" />

</head>


<body>

<form id="form1" runat="server">


<div class="auth-page">

    <main class="auth-shell">


        <!-- ======================
             LEFT HERO
             ====================== -->

        <section class="auth-hero">

            <div class="hero-content">


                <div class="brand-header">

                    <img
                        src="Images/byte-builders-b-v3.png"
                        alt="Byte Builders"
                        class="brand-logo" />


                    <div class="brand-wordmark">

                        <span class="brand-byte">
                            BYTE
                        </span>

                        <span class="brand-builders">
                            BUILDERS
                        </span>

                    </div>

                </div>


                <div class="hero-eyebrow">
                    Workplace collaboration
                </div>


                <h1 class="hero-title">

                    Build a better

                    <span class="gradient-word">
                        workplace.
                    </span>

                </h1>


                <p class="hero-description">

                    Byte Builders gives employees a safe place
                    to share concerns, collaborate on solutions,
                    build actionable proposals, and follow
                    meaningful change.

                </p>


                <div class="benefits">


                    <div class="benefit">

                        <div class="benefit-icon">
                            01
                        </div>

                        <div>

                            <strong>
                                Share Concerns
                            </strong>

                            <span>
                                Raise workplace issues that matter
                            </span>

                        </div>

                    </div>


                    <div class="benefit">

                        <div class="benefit-icon">
                            02
                        </div>

                        <div>

                            <strong>
                                Collaborate
                            </strong>

                            <span>
                                Develop solutions with coworkers
                            </span>

                        </div>

                    </div>


                    <div class="benefit">

                        <div class="benefit-icon">
                            03
                        </div>

                        <div>

                            <strong>
                                Build Solutions
                            </strong>

                            <span>
                                Turn ideas into actionable proposals
                            </span>

                        </div>

                    </div>


                    <div class="benefit">

                        <div class="benefit-icon">
                            04
                        </div>

                        <div>

                            <strong>
                                Track Progress
                            </strong>

                            <span>
                                Follow management responses and updates
                            </span>

                        </div>

                    </div>


                </div>

            </div>


            <div class="aurora-line"></div>


        </section>



        <!-- ======================
             REGISTRATION FORM
             ====================== -->

        <section class="auth-form-panel">


            <div class="auth-top-link">

                Already have an account?

                <a href="Login.aspx">
                    Sign in
                </a>

            </div>


            <div class="form-eyebrow">
                Join Byte Builders
            </div>


            <h2 class="form-title">
                Create your account
            </h2>


            <p class="form-subtitle">
                Join your workplace feedback community and start
                turning ideas into meaningful change.
            </p>



            <div class="field">

                <label for="txtFirstName">
                    First name
                </label>

                <asp:TextBox
                    ID="txtFirstName"
                    runat="server"
                    CssClass="input"
                    placeholder="Enter your first name" />

            </div>



            <div class="field">

                <label for="txtLastName">
                    Last name
                </label>

                <asp:TextBox
                    ID="txtLastName"
                    runat="server"
                    CssClass="input"
                    placeholder="Enter your last name" />

            </div>



            <div class="field">

                <label for="txtEmail">
                    Email address
                </label>

                <asp:TextBox
                    ID="txtEmail"
                    runat="server"
                    CssClass="input"
                    TextMode="Email"
                    placeholder="name@company.com" />

            </div>



            <div class="field">

                <label for="txtPassword">
                    Password
                </label>

                <asp:TextBox
                    ID="txtPassword"
                    runat="server"
                    CssClass="input"
                    TextMode="Password"
                    placeholder="Create a password" />

            </div>



            <div class="field">

                <label for="txtConfirmPassword">
                    Confirm password
                </label>

                <asp:TextBox
                    ID="txtConfirmPassword"
                    runat="server"
                    CssClass="input"
                    TextMode="Password"
                    placeholder="Confirm your password" />

            </div>



            <asp:Button
                ID="btnCreateAccount"
                runat="server"
                Text="Create account"
                CssClass="primary-button"
                OnClick="btnCreateAccount_Click" />


            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message" />


            <div class="form-divider">
                or
            </div>


            <div class="form-footer">

                Already a member?

                <a href="Login.aspx">
                    Sign in to Byte Builders
                </a>

            </div>


            <div class="security-note">

                <span class="security-icon">
                    ✓
                </span>

                Your account information is protected.

            </div>


        </section>


    </main>

</div>


</form>

</body>

</html>