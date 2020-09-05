<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="BS_Clinic.login" EnableEventValidation="false" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="icon" href="img/favicon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="img/favicon.png">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <title>BS-Clinic | تسجيل الدخول </title>

    <!--=====================================================================================================-->

    <link rel="stylesheet" type="text/css" href="css/login.css">
    <link rel="stylesheet" type="text/css" href="css/nice-select1.css">
    <!-- Login CSS -->
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- FontAwesome CSS -->
    <!--script src="js/login.js"></script> JS file -->

</head>

<body>
        <div class="box">

            <div class="row login-tab">
                <div class="col login link" id="login-link">
                    <h4 id="login-heading">تسجيل الدخول </h4>
                </div>
            </div>

            <!--LOGIN -->
            <div id="login-box">
                <form runat="server" id="form1">
                    <div id="stat" runat="server"></div>
                    <div class="form-group">
                        <asp:TextBox ID="loginuser" runat="server" type="text" name="username" required />
                        <label for="username">اسم المستخدم </label>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="loginpass" runat="server" type="password" name="password" required />
                        <i toggle="#loginpass" class="fa fa-eye toggle-password" id="toggle-login-pass"></i>
                        <label for="password">كلمة المرور </label>
                    </div>
                    <div class="row remember-forgot-tab">
                        <div class="col forgot-pass">
                            <label>
                                <a href="Index.aspx" name="forgot-pass"> العودة للصفحة الرئيسية </a>
                            </label>
                        </div>
                      <div class="col forgot-pass">
                        <label> <a href="signup.aspx" name="forgot-pass"> ليس لدي حساب </a> </label>
                      </div>
                    </div>
                    <asp:LinkButton ID="btn_login" runat="server" type="submit" CssClass="btn btn-outline-info btn-block" OnClick="btn_login_Click"> تسجيل دخول </asp:LinkButton>
                </form>
            </div>
            <!-- end of login-box -->

        </div>
        <!--end of container box -->
    <script>
        // hide signup form when website first loads
        $(document).ready(function () {
          //  $('#signup-box').hide();
            $('#login-link').css({
                "color": "#ccc",
                "border": "1px solid #59B4B4"
            });
        });

        /***********************************************************************************************************************/
        //show signup and hide login after on clicking signup link
        $('#signup-link').click(function () {
            $('#login-box').hide(500, function () {
                $('#signup-box').show(500); //show signup box
                linkStyleOnClick($('#signup-link')); //CSS on click of signup link
                linkStyleOffClick($('#login-link')) //change the color and border of login link to its original color
                $('#login-form').trigger("reset"); //Reset login form once signup is clicked
                resetEyeToggle($('#toggle-login-pass')); //Resetting login eye toggle
            });
        });

        //show login and hide signup on clicking login link
        $('#login-link').click(function () {
            $('#signup-box').hide(500, function () {
                $('#login-box').show(500); //show login box
                linkStyleOnClick($('#login-link')); //CSS on click of login link
                linkStyleOffClick($('#signup-link')) //change the color and border of signup link to its original color
                $('#signup-form').trigger("reset"); //Reset signup form once login is clicked
                //Resetting signup pass and confirm eye toggle
                resetEyeToggle($('#toggle-signup-pass'));
                resetEyeToggle($('#toggle-confirm-pass'));
            });
        });

        function linkStyleOnClick(link) {
            link.css({
                "color": "#ccc",
                "border": "1px solid #59B4B4"
            });
        }

        function linkStyleOffClick(link) {
            link.css({
                "color": "#59B4B4",
                "border": "none"
            });
        }

        //Resetting Eye Toggle on leaving the particular box
        function resetEyeToggle(eye) {
            if (eye.hasClass('fa-eye-slash')) {
                eye.removeClass('fa-eye-slash');
                eye.addClass('fa-eye');
                var input = $(eye.attr("toggle"));
                input.attr("type", "password");
            }
        }

        /***********************************************************************************************************************/
        //changing color hovering on login-link and returning back to its original color if its in signup-box
        $(document).ready(function () {
            $('.login-tab').find('.col').hover(function () {
                $(this).css("color", "#ccc");
            }, function () {
                // out hover function --- change the color if only that box is not visible
                if ($('#login-box').is(':hidden')) {
                    $('#login-link').css("color", "#59B4B4");
                }

                if ($('#signup-box').is(':hidden')) {
                    $('#signup-link').css("color", "#59B4B4");
                }
            });
        });

        /***********************************************************************************************************************/
        //Toggle eye icon of login pass
        $('#toggle-login-pass').click(function () {
            toggleEye($(this));
        });

        //Toggle eye icon of signup pass
        $('#toggle-signup-pass').click(function () {
            toggleEye($(this));
        });

        //Toggle eye icon of confirm pass
        $('#toggle-confirm-pass').click(function () {
            toggleEye($(this));
        });

        //function TO toggle EYE ICON of passwords
        function toggleEye(eye) {
            eye.toggleClass("fa-eye fa-eye-slash");
            var input = $(eye.attr("toggle"));
            if (eye.hasClass("fa-eye-slash")) {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        }
  </script>

</body>

</html>
