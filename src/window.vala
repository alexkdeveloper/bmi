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
             alert("Enter the name");
             entry_weight.grab_focus();
             return;
         }
         if(is_empty(entry_height.get_text())){
             alert("Enter the day of births");
             entry_height.grab_focus();
             return;
         }
         if(is_empty(entry_wrist.get_text())){
             alert("Enter the year of births");
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
        s_gender="Пол: мужской";
    }else{
        gender=16;
        s_gender="Пол: женский";
    }
     user_h=user_h/100;
     index=user_w/(user_h*user_h);
     index=index*(gender/user_c);

     if(index<16)s="Дефицит веса";
     else if(index>=16&&index<20)s="Недостаточный вес";
     else if(index>=20&&index<25)s="Норма";
     else if(index>=25&&index<30)s="Предожирение";
     else if(index>=30&&index<35)s="Первая степень ожирения";
     else if(index>=35&&index<40)s="Вторая степень ожирения";
     else s="Морбидное ожирение";

     stack.visible_child = window_result_page;
     set_widget_visible(back_button,true);

     text_view.buffer.text=s_gender+"\n"+somato_type(gender, user_c)+"\n"+"ИМТ: "+index.to_string()+"\n"+s+"\n"+normal_mass_min(user_c, user_h, gender)
     +"\n"+normal_mass_max(user_c, user_h, gender);
		}
		private string normal_mass_min(float x,float y,int z){
        return "Нижняя граница нормального веса: "+(20*(x*(y*y)/z)).to_string()+" кг.";
    }
    private string normal_mass_max(float x,float y,int z){
        return "Верхняя граница нормального веса: "+(25*(x*(y*y)/z)).to_string()+" кг.";
    }
    private string somato_type(int a,float b){
        string s="",s_type_a="Тип телосложения: астенический",s_type_n="Тип телосложения: нормостенический",s_type_h="Тип телосложения: гиперстенический";
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
