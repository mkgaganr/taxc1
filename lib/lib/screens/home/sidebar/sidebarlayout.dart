import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:after_layout/after_layout.dart';
import 'package:taxc/screens/home/sidebar/sidebaritem.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SidebarLayout(),
      )
  );
}
class SidebarLayout extends StatefulWidget {
  @override
  _SidebarLayoutState createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> with AfterLayoutMixin{
  LabeledGlobalKey _importtax = LabeledGlobalKey("importtax");
  LabeledGlobalKey _gsttax = LabeledGlobalKey("gsttax");
  LabeledGlobalKey _news= LabeledGlobalKey("news");
  LabeledGlobalKey _rules = LabeledGlobalKey("rules");
  int selectedindex = 0;
  RenderBox renderBox;
  double startYposition;
  void ontap(int i){
    setState(() {
      selectedindex = i;
      switch (selectedindex){
        case 0:
          renderBox = _importtax.currentContext.findRenderObject();
          break;
        case 1:
          renderBox = _gsttax.currentContext.findRenderObject();
          break;
        case 2:
          renderBox = _news.currentContext.findRenderObject();
          break;
        case 3:
          renderBox = _rules.currentContext.findRenderObject();
          break;
      }
      startYposition = renderBox.localToGlobal(Offset.zero).dy;

    });
  }
  @override

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          width: 70,
          top: 0,
          bottom: 0,
          right:  2,
          child: ClipPath(
            clipper: SidebarClipper((startYposition == null) ? 180 : startYposition-40,
                (startYposition == null) ? 180 : startYposition + 70),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors:[
                      Colors.blueAccent.shade400,
                      Colors.blueAccent.shade400,
                      Colors.blueAccent.shade400
                    ],
                    stops: [
                      0.0,1.0,1.0
                    ],
                  )
              ),
            ),
          ),
        ),

        Positioned(
          right:-22,
          top: 0,
          bottom: 30,
          child: Column(
            children: [
              SizedBox(height: 40,),
              IconButton(
                icon:Icon(
                  Icons.notifications_active,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 18,),
              IconButton(
                icon:Icon(
                  Icons.dashboard,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20,),

              SizedBox(height: 50,),

              Expanded(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SidebarItem(
                        key : _importtax,
                        text: " import tax ",
                        onTabTap: () {ontap(0);},
                        isSelected: selectedindex == 0,
                      ),
                      SidebarItem(
                        key : _gsttax,
                        text: " gst tax ",
                        onTabTap: () {ontap(1);},
                        isSelected: selectedindex == 1,
                      ),
                      SidebarItem(
                        key: _news,
                        text: "news",
                        onTabTap: () {ontap(2);},
                        isSelected: selectedindex == 2,
                      ),
                      SidebarItem(
                        key: _rules,
                        text: "rules",
                        onTabTap: () {ontap(3);},
                        isSelected: selectedindex == 3,
                      ),
                    ],
                  )
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      renderBox = _importtax.currentContext.findRenderObject();
      startYposition = renderBox.localToGlobal(Offset.zero).dy;
    });
  }
}

class SidebarClipper extends CustomClipper<Path>{

  final double startYposition,endYposition;

  SidebarClipper(this.startYposition, this.endYposition);
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    //up curve
    path.moveTo(width, 0);
    path.quadraticBezierTo(width / 3, 5, width / 3, 70);

    //custom curve
    /*path.lineTo(width / 3, startYposition);
       path.lineTo(0, startYposition);
        path.lineTo(0, endYposition);
         path.lineTo(width / 3, endYposition);*/
    path.lineTo(width / 3, startYposition);
    path.quadraticBezierTo(width / 3 -2, startYposition + 15, width / 3 - 10, startYposition + 25);
    path.quadraticBezierTo(0, startYposition + 45, 0, startYposition + 60);
    path.quadraticBezierTo(0, endYposition - 45, width / 3 - 10, endYposition - 25);
    path.quadraticBezierTo(width / 3 -2, endYposition - 15, width / 3, endYposition);

    //down curve
    path.lineTo(width / 3, height - 70);
    path.quadraticBezierTo(width / 3 , height-5, width , height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;


}