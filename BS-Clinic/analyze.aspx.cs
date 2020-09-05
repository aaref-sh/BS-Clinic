using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace BS_Clinic
{
    public partial class analyze : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);
        public string res, name;
        public int age, weight, suger;
        int[,] info; int p1, p2, p3;
        int s = 9999, m, max;
        double[] mn = new double[3];
        double[] mx = new double[3];
        double[] md = new double[3];
        double[] l1 = new double[3] { -1, -1, -1 };
        double[] l2 = new double[3] { -1, -1, -1 };
        double[] l3 = new double[3] { -1, -1, -1 };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["admin"] == null && Request.Cookies["patient"] == null)
                Response.Redirect("~/login.aspx");

            string exm = Request.QueryString["exm"];
            suger = Convert.ToInt32(Get_data("select res from mexam where id = "+exm).Rows[0][0]);

            string query = "select * from mexam";
            DataTable dt = Get_data(query);
            
            max = dt.Rows.Count;
            info = new int[max,3];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                info[i,0] = Convert.ToInt32(dt.Rows[i][5].ToString());
                DataRow dr = Get_data("select * from patient where id = " + dt.Rows[i][1].ToString()).Rows[0];
                info[i,1] = Convert.ToInt32(dr[5]);
                info[i,2] = DateTime.Now.Year - Convert.ToDateTime(dr[3]).Year;
                int now = info[i,0];

                if (s > now)
                {
                    s = now;
                    mn[0] = info[i,0];
                    mn[1] = info[i,1];
                    mn[2] = info[i,2];
                }
                if (m < now)
                {
                    m = now;
                    mx[0] = info[i,0];
                    mx[1] = info[i,1];
                    mx[2] = info[i,2];
                }

            }
            md[0] = (mn[0] + mx[0]) * 1.0 / 2;
            md[1] = (mn[1] + mx[1]) * 1.0 / 2;
            md[2] = (mn[2] + mx[2]) * 1.0 / 2;
            Anal();
            DataRow dd = Get_data("select * from patient where id = (select patient_id from mexam where id = " + exm + ")").Rows[0];
            name = dd[1].ToString();
            age = DateTime.Now.Year - Convert.ToDateTime(dd[3]).Year;
            weight = Convert.ToInt32(dd[5]);
            int[] k = new int[3] { suger, weight, age };
            if (suger < 60)
            {
                res = "نسبة السكر منخفضة جداً، عليك تناول وجبة غنية بالكربوهيدرات ومراجعة العيادة";
                return;
            }
            else
            {
                if (Dis(l1, k) <= Dis(l2, k) && Dis(l1, k) <= Dis(l3, k))
                    res = "صحيح، لا يحتاج إلى أي علاج";
                else if (Dis(l2, k) <= Dis(l1, k) && Dis(l2, k) <= Dis(l3, k))
                    res = "السكر مرتفع نسبياً، يحتاج إلى رعاية طبية في المنزل وتحسين النظام الغذائي ونمط الحياة";
                else res = "الحالة خطرة!!! نسبة سكر الدم مرتفعة جدا ويحتاج إلى عناية مركزة";
            }
        }
        protected void Sign_out(object sender, EventArgs e)
        {
            if (Request.Cookies["admin"] != null)
                Response.Cookies["admin"].Expires = DateTime.Now.AddDays(-1);
            if (Request.Cookies["patient"] != null)
                Response.Cookies["patient"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/Index.aspx");
        }
        private void Anal()
        {
            p1 = p2 = p3 = 0;
            int  s1 = 0, s2 = 0, s3 = 0, w1 = 0, w2 = 0, w3 = 0, a1 = 0, a2 = 0, a3 = 0;

            for(int i = 0; i < max; i++)
            {
                double dis1 = Dis(mn, info.GetRow(i));
                double dis2 = Dis(md, info.GetRow(i));
                double dis3 = Dis(mx, info.GetRow(i));

                if(dis1 <= dis2 && dis1 <= dis3)
                {
                    s1 += info.GetRow(i)[0];
                    w1 += info.GetRow(i)[1];
                    a1 += info.GetRow(i)[2];
                    p1++;
                }

                else if(dis2 <= dis1 && dis2 <= dis3)
                {
                    s2 += info.GetRow(i)[0];
                    w2 += info.GetRow(i)[1];
                    a2 += info.GetRow(i)[2];
                    p2++;

                }

                else
                {
                    s3 += info.GetRow(i)[0];
                    w3 += info.GetRow(i)[1];
                    a3 += info.GetRow(i)[2];
                    p3++;
                }
            }

            if (p1 > 0) { mn[0] = 1.0 * s1 / p1; mn[1] = 1.0 * w1 / p1; mn[2] = 1.0 * a1 / p1; }
            if (p2 > 0) { md[0] = 1.0 * s2 / p2; md[1] = 1.0 * w2 / p2; md[2] = 1.0 * a2 / p2; }
            if (p3 > 0) { mx[0] = 1.0 * s3 / p3; mx[1] = 1.0 * w3 / p3; mx[2] = 1.0 * a3 / p3; }

            if (Ec(mn, l1) && Ec(md, l2) && Ec(mx, l3)) return;

            l1[0] = mn[0];l1[1] = mn[1];l1[2] = mn[2];
            l2[0] = md[0];l2[1] = md[1];l2[2] = md[2];
            l3[0] = mx[0];l3[1] = mx[1];l3[2] = mx[2];

            Anal();
        }
        
        private bool Ec(double[] a, double[] b)
        {
            for (int i = 0; i < a.Length; i++) if (a[i] != b[i]) return false;
            return true;
        }

        double Dis (double[]a , int[] b)
        {
            return Math.Sqrt((a[0]-b[0]) * (a[0]-b[0]) + (a[1]-b[1]) * (a[1]-b[1]) + (a[2]-b[2]) * (a[2]-b[2]));
        }
        private DataTable Get_data(string query)
        {
            SqlCommand cmd = new SqlCommand(query, con);
            DataTable dt = new DataTable();
            con.Open();
            dt.Load(cmd.ExecuteReader());
            con.Close();
            return dt;
        }
    }
    public static class ArrayExt
    {
        public static T[] GetRow<T>(this T[,] array, int row)
        {
            if (!typeof(T).IsPrimitive)
                throw new InvalidOperationException("Not supported for managed types.");

            if (array == null)
                throw new ArgumentNullException("array");

            int cols = array.GetUpperBound(1) + 1;
            T[] result = new T[cols];

            int size;

            if (typeof(T) == typeof(bool))
                size = 1;
            else if (typeof(T) == typeof(char))
                size = 2;
            else
                size = System.Runtime.InteropServices.Marshal.SizeOf<T>();

            Buffer.BlockCopy(array, row * cols * size, result, 0, cols * size);

            return result;
        }
    }
}