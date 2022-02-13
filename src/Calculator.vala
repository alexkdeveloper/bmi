namespace Bmi {
    public class Calculator {
        public float calculate_index(float h, float w,float c, int gender){
            float index;
            h=h/100;
            index=w/(h*h);
            index=index*(gender/c);
            return index;
        }
        public string calculate_result(float index){
            string s;
            if(index<16)s=_("Deficiency of weight");
            else if(index>=16&&index<20)s=_("Insufficient weight");
            else if(index>=20&&index<25)s=_("Norm");
            else if(index>=25&&index<30)s=_("Pre-obese");
            else if(index>=30&&index<35)s=_("The first degree of obesity");
            else if(index>=35&&index<40)s=_("Second degree of obesity");
            else s=_("Morbid obesity");
            return s;
        }
        public string normal_mass_min(float x,float y,int z){
            y = y/100;
            return _("Lower limit of normal weight: %f kg.").printf(20*(x*(y*y)/z));
        }
        public string normal_mass_max(float x,float y,int z){
            y = y/100;
            return _("Upper limit of normal weight: %f kg.").printf(25*(x*(y*y)/z));
        }
        public string somato_type(int a,float b){
            string s="",s_type_a=_("Body type: asthenic"),s_type_n=_("Body type: normosthenic"),s_type_h=_("Body type: hypersthenic");
            switch(a){
                case 19:
                    if(b<18)s=s_type_a;
                    else if(b>=18&&b<=20)s=s_type_n;
                    else s=s_type_h;
                    break;
                case 16:
                    if(b<15)s=s_type_a;
                    else if(b>=15&&b<=17)s=s_type_n;
                    else s=s_type_h;
                    break;
                    default:
                    break;
            }
            return s;
        }
    }
}