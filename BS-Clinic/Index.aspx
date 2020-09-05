<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="BS_Clinic.Index" EnableEventValidation="false"%>

<!doctype html>
<html lang="en">

<head runat="server">
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>BS-Clinic | الرئيسية</title>
    <link rel="icon" href="img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <!-- themify CSS -->
    <link rel="stylesheet" href="css/themify-icons.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="css/flaticon.css">
    <!-- magnific popup CSS -->
    <link rel="stylesheet" href="css/magnific-popup.css">
    <!-- nice select CSS -->
    <link rel="stylesheet" href="css/nice-select.css">
    <!-- swiper CSS -->
    <link rel="stylesheet" href="css/slick.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    <form id="form1" runat="server">
        <% bool b = false;
            HttpCookie cookie = HttpContext.Current.Request.Cookies["admin"];
            HttpCookie cookie1 = HttpContext.Current.Request.Cookies["patient"];
            if (cookie != null || cookie1 != null) b = true;
            %>
        <!--::header part start::-->
        <header class="main_menu home_menu text-right">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-12">
                        <nav class="navbar navbar-expand-lg navbar-light">
                            <a class="navbar-brand" href="index.html">
                                <img src="img/logo.png" alt="logo">
                            </a>
                            <button class="navbar-toggler" type="button" data-toggle="collapse"
                                data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>

                            <div class="collapse navbar-collapse main-menu-item justify-content-end"
                                id="navbarSupportedContent">
                                <ul class="navbar-nav align-items-center">
                                    <li class="nav-item active">
                                        <a class="nav-link" href="index.aspx">الرئيسية</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="appointment.aspx">المواعيد</a>
                                    </li>


                                    <li class="nav-item">
                                        <a class="nav-link" href="contact.aspx">التواصل</a>
                                    </li>
                                    <li class="nav-item">
                                        <%
                                            if (b)
                                            { %>  <asp:LinkButton runat="server" CssClass="nav-link" OnClick="sign_out">تسجيل خروج</asp:LinkButton><%}
                                        else
                                        {%>

                                        <a class="nav-link" href="login.aspx">تسجيل الدخول</a>
                                        <%} %>

                                    </li>
                                    <li class="nav-item">
                                        <p>الإسعاف 2444444 </p>
                                    </li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </header>
        <!-- Header part end-->

        <!-- banner part start-->
        <section class="banner_part text-right">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 col-xl-6">
                        <div class="banner_text">
                            <div class="banner_text_iner">
                                <h1>عيادة سكر الدم الأقرب إليك</h1>
                                <p>ما يميزنا هو الخبرة العتيدة المتجددة باستمرار وتقديم التكنولوجيا الطبية الحديثة التي تقيم الحالة الصحية بسرعة وكفاءة </p>
                                <!-- Button trigger modal -->
                                <button type="button" class="btn_2" data-toggle="modal" data-target="#exampleModalLong">
                                    هل حالتي خطيرة؟
                                </button>

                                <!-- Modal -->
                                <div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title tex" id="exampleModalLongTitle">عوامل خطورة اعتلال سكر الدم</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body" style="font-size: 17px;" dir="rtl">
                                                أهم أعراض ارتفاع نسبة الجلوكوز في الدم والتي تسمى الأعراض الكلاسيكية:
                                            <br>
                                                زيادة الجلوكوز في البول والتي تؤدي إلى زيادة في التبول وكمية البول.
                                            <br>
                                                العطش الشديد وشرب السوائل بكثرة.
                                            <br>
                                                الضعف العام  والهزال.
                                            <br>
                                                التعرق.
                                            <br>
                                                وفي حال ما إذا استمر ارتفاع جلوكوز الدم لمدة طويلة بدرجات عالية اكثر من ٢٥٠ ملغ٪‏ ، وصاحب ذلك ارتفاع في درجة الحرارة فان ذلك يؤدي إلى حالة خطيرة جدا تسمى الحماض الكيتوني والتي تستدعي العلاج المستعجل و المتخصص في المستشفى.
                                            <br>
                                                إن ما يهمنا في حالات ارتفاع جلوكوز الدم هو المحافظة على العلاج المناسب  فهو الضمان الأمثل لتجنب كافة مضاعفات مرض السكري المزمنة والحادة.
                                            <br>
                                                <hr>
                                                إن حدة وجود أحد هذه الأعراض يتطلب عناية داخل المشفى لمراقبة حالة المريض
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">إغلاق</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="banner_item text-center">
                                    <div class="single_item">
                                        <img src="img/icon/banner_1.svg" alt="">
                                        <h5>استشارات طارئة</h5>
                                    </div>
                                    <div class="single_item">
                                        <img src="img/icon/banner_2.svg" alt="">
                                        <h5>تقديم برامج صحية</h5>
                                    </div>
                                    <div class="single_item">
                                        <img src="img/icon/banner_3.svg" alt="">
                                        <h5>خبرة</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- banner part start-->

        <!-- feature_part start-->
        <section class="feature_part padding_top">
            <div class="container">
                <div class="row" dir="rtl">
                    <div class="col-xl-4 col-md-4 align-self-center">
                        <div class="single_feature_text text-right">
                            <h2>نقدم خدمات
                                خاصة</h2>
                            <p>
                                إن ما يميزنا عن غيرنا هو الخدمات الفريدة التي نقدمها 
                                بدمج التكنولوجيا الطبية بسهولة الوصول وبساطة التصميم
                                تجعلنا أكثر من مجرد موقع أو عيادة افتراضية.
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-8">
                        <div class="feature_item">
                            <div class="row">
                                <div class="col-lg-6 col-sm-6">
                                    <div class="single_feature">
                                        <div class="single_feature_part">
                                            <span class="single_feature_icon">
                                                <img src="img/icon/add-male-user.svg"
                                                    alt=""></span>
                                            <h4>التسجيل السريع</h4>
                                            <p class="text-right">
                                                التسجيل لدينا سهل وسريع ومجاني وغير معقد
                                                حيث أن أغلب مستخدمي عيادتنا هم من كبار السن وكارهي عمليات التأكيد ورسائل البريد الالكتروني
                                                فإننا نقدم طريقة تسجيل سلسة وسهلة ولا تتطلب أي ارتباطات خارج الموقع
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-sm-6">
                                    <div class="single_feature">
                                        <div class="single_feature_part">
                                            <span class="single_feature_icon">
                                                <img src="img/icon/computer-report.svg"
                                                    alt=""></span>
                                            <h4>التحليل الآلي</h4>
                                            <p class="text-right">
                                                بخدمات الحوسبة والتحليل الآلي يمكن للأطباء الاستعانة بأنظمتنا 
                                                التي تقوم بتحليل ومقارنة عدد هائل من البيانات في وقت وجيز
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-sm-6">
                                    <div class="single_feature">
                                        <div class="single_feature_part">
                                            <span class="single_feature_icon">
                                                <img src="img/icon/doctor-team.svg"
                                                    alt=""></span>
                                            <h4>الخبرة الطبية</h4>
                                            <p class="text-right">
                                                خبرتنا الطبية العالية والمتحدثة المواكبة لكل الأبحاث الجديدة 
                                                باختصار نحن موسوعة طبية لخدمتك بين يديك
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-sm-6">
                                    <div class="single_feature">
                                        <div class="single_feature_part">
                                            <span class="single_feature_icon">
                                                <img src="img/icon/computer-businesswoman.svg"
                                                    alt=""></span>
                                            <h4>مستعدون دائماً</h4>
                                            <p class="text-right">
                                                نظامنا الإلكتروني قوي ومتماسك يعمل على مدار الساعة<br>
                                                تحديثات النظام شفافة عن المستخدمين وفريقنا الهندسي مستعد دائما لإصلاح أي خلل فور حدوثه 
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- feature_part start-->


        <!-- top_service part start-->
        <section class="top_service our_ability padding_bottom text-right" dir="rtl">
            <div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-md-5 col-lg-5">
                        <div class="our_ability_member_text">
                            <h2>كيف أقوم بحجز موعد؟</h2>
                            <p>عند قيامك بتسجيل الدخول يمكنك حجز موعد واحد فقط لنفسك.
                                <br /> كما يمكنك التواصل مع الطبيب ليقوم بحجز موعد لك.
                                <br /> وننوّه إلى أن الجز يتم ضمن الاسبوع الحالي فقط ولا يتم حجز أي موعد للاسبوع القادم سواء أكان ذاتياً أم عن طريق الطبيب.
                                <br /> يفتح باب حجز المواعيد للاسبوع الجديد في مطلع كل يوم سبت في تمام الساعة 12:00AM منتصف الليل وحتى نهاية الاسبوع.

                            </p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="our_ability_img">
                            <img src="img/bapp.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- our_ability part start-->
        <section class="our_ability section_padding text-right" dir="rtl">
            <div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-md-6 col-lg-6">
                        <div class="our_ability_img">
                            <img src="img/ability_img.png" alt="">
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-5">
                        <div class="our_ability_member_text">
                            <h2>عنايتنا فائقة</h2>
                            <p>
                                الحفاظ على شرف المهنة والأمانة الطبية هي الركيزة التي نبني عليها منصتنا الطبية<br>
                                أرواح المرضى أمانة بين أيدينا وبذلك نسعى دائما لتطوير واختبار منصتنا باقسى الاختبارات وتحت كل الظروف المعتادة أو الخاصة لنتأكد دوماً من خلوها 
                                من أي حدث قد يضر في صحة المرضى لدينا
                            </p>
                            <ul>
                                <li><span class="ti-mouse"></span>تقنيات حديثة</li>
                                <li><span class="ti-heart-broken"></span>استشارات طبية حرجة</li>
                                <li><span class="ti-package"></span>خبرات تراكمية</li>
                                <li><span class="ti-headphone-alt"></span>دعم 24/7</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- our_ability part end-->

        <!-- top_service part start-->
        <section class="top_service our_ability padding_bottom text-right" dir="rtl">
            <div class="container">
                <div class="row justify-content-between align-items-center">
                    <div class="col-md-5 col-lg-5">
                        <div class="our_ability_member_text">
                            <h2>نقوم بتحليل بياناتك الصحية لنقدم لك الخدمة الأفضل</h2>
                            <p>نظامنا يعتمد لتحليل الحالة على الحوسبة وتقسيم المجموعات وفق تقنيات معتمدة عالمياً</p>
                            <a href="QuickAnalysis.aspx" class="btn_2">تحليل آلي سريع</a>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="our_ability_img">
                            <img src="img/top_service.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- top_service part end-->

        <!--::review_part start::-->
        <section class="review_part text-right">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="client_review_part owl-carousel">
                            <div class="client_review_single">
                                <img src="img/Quote.png" class="Quote" alt="quote">
                                <div class="client_review_text">
                                    <p>
                                        لا تتوانى عن طلب الاستشارات عندما تراودك الشكوك حول ظهور أحد أعراض خلل نسبة سكر الدم
                                        <br>
                                        خاصة لمن تكون مورثات المرض منتشرة في عائلتهم أو لديهم تجربة سابقة مع المرض
                                    </p>
                                </div>
                                <h4>حازم الزين, <span>أخصائي باطنة</span></h4>
                            </div>
                            <div class="client_review_single">
                                <img src="img/Quote.png" class="Quote" alt="quote">
                                <div class="client_review_text media-body">
                                    <p>
                                        إن النظام الغذائي الصحي والمتوازن هو أهم ما يمكن أن يدعم توازن البيئة الداخلية للجسم
                                        <br>
                                        الخضار والفواكة الطازجة والمكسرات تقيك من طيف واسع من الأمراض وتبقي نظامك الداخلي في أفضل حالاته 
                                    </p>
                                </div>
                                <h4>عبد الستار قلعجي, <span>أخصائي تغذية</span></h4>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--::review_part end::-->

        <!-- footer part start-->
        <footer class="footer-area">

            <div class="copyright_part">
                <div class="container">
                    <div class="row align-items-center">
                        <p class="footer-text text-center m-0 col-lg-8 col-md-12">
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        made with <i class="ti-heart" aria-hidden="true"></i> by <br /> Dyana Al-Jajeh - Abeer Attal Othmanly - Nourulhuda Al-Halabi - Nour Al-Akhras - Nour Hadeed - Sara Sabsabi
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </p>
                        <div class="col-lg-4 col-md-12 text-center text-lg-right footer-social">
                            <a href="#"><i class="ti-facebook"></i></a>
                            <a href="#"><i class="ti-twitter"></i></a>
                            <a href="#"><i class="ti-instagram"></i></a>
                            <a href="#"><i class="ti-skype"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <!-- footer part end-->
    </form>
    <!-- jquery plugins here-->

    <script src="js/jquery-1.12.1.min.js"></script>
    <!-- popper js -->
    <script src="js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- easing js -->
    <script src="js/jquery.magnific-popup.js"></script>
    <!-- swiper js -->
    <script src="js/swiper.min.js"></script>
    <!-- swiper js -->
    <script src="js/masonry.pkgd.js"></script>
    <!-- particles js -->
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <!-- swiper js -->
    <script src="js/slick.min.js"></script>
    <script src="js/jquery.counterup.min.js"></script>
    <script src="js/waypoints.min.js"></script>
    <!-- contact js -->
    <script src="js/jquery.ajaxchimp.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    <script src="js/mail-script.js"></script>
    <script src="js/contact.js"></script>
    <!-- custom js -->
    <script src="js/custom.js"></script>
</body>

</html>
