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
	[GtkTemplate (ui = "/com/github/alexkdeveloper/bmi/Window.ui")]
	public class Window : Gtk.ApplicationWindow {
		[GtkChild]
        unowned Gtk.Stack stack;
        [GtkChild]
        unowned Gtk.Box box_data_page;
        [GtkChild]
        unowned Gtk.Box box_result_page;
        [GtkChild]
        unowned Gtk.Label index_result;
        [GtkChild]
        unowned Gtk.Label type_result;
        [GtkChild]
        unowned Gtk.Label result;
        [GtkChild]
        unowned Gtk.Label min_mass;
        [GtkChild]
        unowned Gtk.Label max_mass;
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
            entry_weight.grab_focus();
           }
        });
        entry_height.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_height.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
              entry_height.set_text("");
              entry_height.grab_focus();
           }
        });
        entry_wrist.set_icon_from_icon_name (Gtk.EntryIconPosition.SECONDARY, "edit-clear-symbolic");
        entry_wrist.icon_press.connect ((pos, event) => {
        if (pos == Gtk.EntryIconPosition.SECONDARY) {
              entry_wrist.set_text("");
              entry_wrist.grab_focus();
           }
        });
            set_widget_visible(back_button,false);
            back_button.clicked.connect(go_to_data_page);
            calculate_button.clicked.connect(on_calculate);
          var css_provider = new Gtk.CssProvider();
       try {
                css_provider.load_from_data(".index_size {font-weight: bold; font-size: 15px} .norm_result {color: green; font-size: 18px} .not_norm_result{color: red; font-size: 18px}");
                Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
            } catch (Error e) {
                error ("Cannot load CSS stylesheet: %s", e.message);
        }
		}
		private void on_calculate(){
         if(is_empty(entry_weight.get_text())){
             alert(_("Please enter the weight"));
             entry_weight.grab_focus();
             return;
         }
         if(is_empty(entry_height.get_text())){
             alert(_("Please enter the height"));
             entry_height.grab_focus();
             return;
         }
         if(is_empty(entry_wrist.get_text())){
             alert(_("Please enter the length of the wrist circumference"));
             entry_wrist.grab_focus();
             return;
         }

        float user_h,user_w,user_c;

        user_h=float.parse(entry_height.get_text());
        user_w=float.parse(entry_weight.get_text());
        user_c=float.parse(entry_wrist.get_text());

        float index;
        int gender;
        string s;
    if (combobox.get_active()==0){
        gender=19;
    }else{
        gender=16;
    }
    var calculator = new Calculator();
    
     index = calculator.calculate_index(user_h, user_w, user_c, gender);

     s = calculator.calculate_result(index);

     stack.visible_child = box_result_page;
     set_widget_visible(back_button,true);

     if(s==_("Norm")){
         result.get_style_context().remove_class("not_norm_result");
         result.get_style_context().add_class("norm_result");
     }else{
         result.get_style_context().remove_class("norm_result");
         result.get_style_context().add_class("not_norm_result");
     }

     index_result.get_style_context().add_class("index_size");

     index_result.set_text(_("BMI: %f").printf(index));
     type_result.set_text(calculator.somato_type(gender, user_c));
     result.set_text(s);
     min_mass.set_text(calculator.normal_mass_min(user_c, user_h, gender));
     max_mass.set_text(calculator.normal_mass_max(user_c, user_h, gender));
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
          var dialog = new Granite.MessageDialog.with_image_from_icon_name (_("Message"), str, "dialog-warning");
                  dialog.show_all ();
                  dialog.run ();
                  dialog.destroy ();
       }
	}
}
