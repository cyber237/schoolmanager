import 'package:flutter/material.dart';

class SlideBoard extends StatelessWidget {
  SlideBoard({@required this.imagePath, @required this.info});
  final String imagePath;
  final String info;
  final TextStyle _infoStyle = new TextStyle(
      fontSize: 22, fontWeight: FontWeight.w600, color: Colors.grey.shade50);
  final Radius _boxRadius = Radius.circular(20);
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          borderRadius:
              BorderRadius.only(topLeft: _boxRadius, bottomRight: _boxRadius)),
      child: new Column(
        children: [
          Expanded(
            flex: 2,
            child: new Image.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 1,
            child: new Container(
              child: new Text(
                info,
                textAlign: TextAlign.center,
                style: _infoStyle,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomShapeButton extends StatefulWidget {
  CustomShapeButton(
      {Key key, this.name, this.onTap, this.textColor, this.buttonColor})
      : super(key: key);
  final String name;
  final void onTap;
  final Color textColor;
  final Color buttonColor;

  @override
  _CustomShapeButtonState createState() => _CustomShapeButtonState();
}

class _CustomShapeButtonState extends State<CustomShapeButton> {
  bool _hovering;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap,
      onTapUp: (_) => setState(() => _hovering = false),
      onTapDown: (_) => setState(() => _hovering = true),
      child: new Container(
        decoration: new BoxDecoration(
            color: _hovering
                ? widget.buttonColor.withOpacity(0.5)
                : widget.buttonColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
        child: new Text(widget.name,
            style: new TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: widget.textColor,
            )),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton({this.text, this.onTap, this.buttColor, this.textColor});
  final String text;
  final Function onTap;
  final Color buttColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return new Container(
        width: _screenWidth * 0.8,
        margin: EdgeInsets.symmetric(vertical: 30),
        height: 70,
        child: new ElevatedButton(
          onPressed: onTap == null
              ? () => null
              : () {
                  onTap();
                },
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // elevation: 5,
          // color: buttColor,
          child: new Text(text,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: textColor, fontSize: 23, fontWeight: FontWeight.w600)),
        ));
  }
}

enum Side { Left, Right }

class FooterButton extends StatelessWidget {
  FooterButton({this.text, this.onTap, this.side, this.large = false});
  final String text;
  final Function onTap;
  final Side side;
  final bool large;
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        onTap();
      },
      child: new Container(
        height: 50,
        width: MediaQuery.of(context).size.width * (large ? 0.9 : 0.46),
        alignment:
            side == Side.Left ? Alignment.centerLeft : Alignment.centerRight,
        child: new Text(
          text,
          textAlign: side == Side.Left ? TextAlign.left : TextAlign.right,
          style: new TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500),
        ),
      ),
    );
  }
}

Container logo(BuildContext context, double ratio) {
  final String _imagePath = "assets/launch/logo.png";
  final double _imageHeight = MediaQuery.of(context).size.height * ratio;
  return new Container(
    height: _imageHeight,
    padding: EdgeInsets.all(10),
    alignment: Alignment.center,
    child: new Image.asset(
      _imagePath,
      fit: BoxFit.fitHeight,
    ),
  );
}
