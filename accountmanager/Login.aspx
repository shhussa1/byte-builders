<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="accountmanager.Login" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <title>Sign In | Byte Builders</title>

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


        <!-- LEFT HERO -->

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

                    Welcome back to

                    <span class="gradient-word">
                        Byte Builders.
                    </span>

                </h1>


                <p class="hero-description">

                    Sign in to share workplace concerns,
                    collaborate with coworkers,
                    build meaningful solutions,
                    and follow proposal progress.

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



        <!-- RIGHT LOGIN PANEL -->

        <section class="auth-form-panel">


            <div class="auth-top-link">

                New to Byte Builders?

                <a href="CreateAccount.aspx">
                    Create account
                </a>

            </div>


            <div class="form-eyebrow">
                Welcome back
            </div>


            <h2 class="form-title">
                Sign in
            </h2>


            <p class="form-subtitle">

                Continue to your workplace feedback community.

            </p>



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
                    placeholder="Enter your password" />

            </div>


            <div class="remember-row">

                <label class="remember-left">

                    <input type="checkbox" />

                    Remember me

                </label>

                <a href="#"
                   class="forgot-link">
                    Forgot password?
                </a>

            </div>



            <asp:Button
                ID="btnLogin"
                runat="server"
                Text="Sign in"
                CssClass="primary-button"
                OnClick="btnLogin_Click" />


            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message" />


            <div class="form-divider">
                or
            </div>


            <div class="form-footer">

                Don't have an account?

                <a href="CreateAccount.aspx">
                    Join Byte Builders
                </a>

            </div>


            <div class="security-note">

                <span class="security-icon">
                    ✓
                </span>

                Secure access to your workplace community.

            </div>


        </section>


    </main>

</div>

</form>

</body>
</html>