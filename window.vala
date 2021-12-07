/* window.vala
 *
 * Copyright 2021 Alex
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Bmi {
	[GtkTemplate (ui = "/com/github/alexkdeveloper/bmi/window.ui")]
	public class Window : Gtk.ApplicationWindow {
		[GtkChild]
        unowned Gtk.Stack stack;
        [GtkChild]
        unowned Gtk.Box box_data_page;
        [GtkChild]
        unowned Gtk.ScrolledWindow window_result_page;
        [GtkChild]
        unowned Gtk.TextView text_view;
        [GtkChild]
        unowned Gtk.ComboBox combobox;
        [GtkChild]
        unowned Gtk.Entry entry_weight;
        [GtkChild]
        unowned Gtk.Entry entry_height;
        [GtkChild]
        unowned Gtk.Entry entry_wrist;
        [GtkChild]
        unowned Gtk.Button back_button;
        [GtkChild]
        unowned Gtk.Button calculate_button;


		public Window (Gtk.Application app) {
			Object (application: app);
            get_style_context().add_class("rounded");
			entry_weight.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_weight.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
            entry_weight.set_text ("");
           }
        });
        entry_height.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_height.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
              entry_height.set_text("");
           }
        });
        entry_wrist.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_wrist.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
              entry_wrist.set_text("");
           }
        });
            set_widget_visible(back_button,false);
            back_button.clicked.connect(go_to_data_page);
            calculate_button.clicked.connect(on_calculate);
		}
		private void on_calculate(){
         if(is_empty(entry_weight.get_text())){
             alert("Enter the weight");
             entry_weight.grab_focus();
             return;
         }
         if(is_empty(entry_height.get_text())){
             alert("Enter the height");
             entry_height.grab_focus();
             return;
         }
         if(is_empty(entry_wrist.get_text())){
             alert("Enter the length of the wrist circumference");
             entry_wrist.grab_focus();
             return;
         }

        float user_h,user_w,user_c;

        user_h=float.parse(entry_height.get_text());
        user_w=float.parse(entry_weight.get_text());
        user_c=float.parse(entry_wrist.get_text());

        float index;
        int gender;
        string s_gender,s;
    if (combobox.get_active()==0){
        gender=19;
        s_gender="Gender: male";
    }else{
        gender=16;
        s_gender="Gender: female";
    }
     user_h=user_h/100;
     index=user_w/(user_h*user_h);
     index=index*(gender/user_c);

     if(index<16)s="Deficiency of weight";
     else if(index>=16&&index<20)s="Insufficient weight";
     else if(index>=20&&index<25)s="Norm";
     else if(index>=25&&index<30)s="Pre-obese";
     else if(index>=30&&index<35)s="The first degree of obesity";
     else if(index>=35&&index<40)s="Second degree of obesity";
     else s="Morbid obesity";

     stack.visible_child = window_result_page;
     set_widget_visible(back_button,true);

     text_view.buffer.text=s_gender+"\n"+somato_type(gender, user_c)+"\n"+"BMI: "+index.to_string()+"\n"+s+"\n"+normal_mass_min(user_c, user_h, gender)
     +"\n"+normal_mass_max(user_c, user_h, gender);
		}
		private string normal_mass_min(float x,float y,int z){
        return "Lower limit of normal weight: "+(20*(x*(y*y)/z)).to_string()+" kg.";
    }
    private string normal_mass_max(float x,float y,int z){
        return "Upper limit of normal weight: "+(25*(x*(y*y)/z)).to_string()+" kg.";
    }
    private string somato_type(int a,float b){
        string s="",s_type_a="Body type: asthenic",s_type_n="Body type: normostenic",s_type_h="Body type: hypersthenic";
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
		private void go_to_data_page(){
           stack.visible_child = box_data_page;
           set_widget_visible(back_button,false);
        }
		private bool is_empty(string str){
        return str.strip().length == 0;
        }
		private void set_widget_visible (Gtk.Widget widget, bool visible) {
         widget.no_show_all = !visible;
         widget.visible = visible;
  }
    private void alert (string str){
          var dialog_alert = new Gtk.MessageDialog(this, Gtk.DialogFlags.MODAL, Gtk.MessageType.INFO, Gtk.ButtonsType.OK, str);
          dialog_alert.set_title("Message");
          dialog_alert.run();
          dialog_alert.destroy();
       }
	}
}
