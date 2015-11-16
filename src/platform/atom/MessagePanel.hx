package platform.atom;

import lib.atom.MessagePanelView;
import lib.atom.PlainMessageView;

import utils.HtmlEscape;

@:enum abstract PanelMessageKind(Int) {
    var INFO = 1;
    var WARN = 2;
    var ERROR = 3;
}

class MessagePanel {

    private static var view:MessagePanelView;

    private static var visible:Bool;

    public static function init():Void {
        view = new MessagePanelView({ title: 'Haxe' });
        visible = false;
    }

    public static function show():Void {
        view.attach();
        visible = true;
    }

    public static function hide():Void {
        view.close();
        visible = false;
    }

    public static function clear():Void {
        view.clear();
    }

    public static function toggle():Void {
        if (visible) hide();
        else show();
    }

    /** Log a visible message on the panel.
        Will handle the parsing of ANSI colors and links to source file or url. */
    public static function message(kind:PanelMessageKind, content:String):Void {
            // Escape HTML
        content = HtmlEscape.escape(content);
            // Add message
        view.add(new PlainMessageView({ message: content, raw: true }));
            // Scroll to top
        untyped view.body.scrollTop(1e10);
            // Display panel
        show();
    }

}
