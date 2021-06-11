import 'package:flutter/material.dart';


class GlobalAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {

          },
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark,
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class StandardAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [
              Colors.green,
              Colors.green,
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem(
      {Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final num rating;
  final Color color;
  final MainAxisAlignment rowAlignment;

  StarRating({
    this.starCount = 5,
    this.rating = .0,
    this.color,
    this.rowAlignment = MainAxisAlignment.center,
  });

  Widget buildStar(
      BuildContext context, int rank, MainAxisAlignment rowAlignment) {
    Icon icon;
    if (rank >= rating) {
      return icon = new Icon(
        Icons.star_border,
        color: Theme.of(context).buttonColor,
      );
    } else if (rank > rating - 1 && rank < rating) {
      return icon = new Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      return icon = new Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: rowAlignment,
      children: new List.generate(
        starCount,
        (rank) => buildStar(context, rank, rowAlignment),
      ),
    );
  }
}

String titleCase(String text) {
  if (text.length <= 1) return text.toUpperCase();
  var words = text.split(' ');
  var capitalized = words.map((word) {
    var first = word.substring(0, 1).toUpperCase();
    var rest = word.substring(1);
    return '$first$rest';
  });
  return capitalized.join(' ');
}

Widget MyHealthTextField({String hintText, String initialValue}) {
  // new
  return Container(
    margin: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      bottom: 20.0,
    ),
    child: TextFormField(
      textAlign: TextAlign.end,
      initialValue: initialValue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        hintText: hintText,
        prefix: Padding(
          padding: EdgeInsets.only(
            right: 15,
          ),
          child: Text(
            hintText,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return '';
        }
        return null;
      },
    ),
  );
}

Widget imageDialog(context, imageUrl) {
  return Dialog(
    child: Container(
      width: MediaQuery.of(context).size.width * 1.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(imageUrl), fit: BoxFit.cover)),
    ),
  );
}

Widget customTextField(context, String hintText, IconData icon) {
  return TextField(
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Color(0xFFb1b2c4),
      ),
      border: new OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(60),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(60),
      ),
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      contentPadding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 25.0,
      ),
      prefixIcon: Icon(
        icon,
        color: Color(0xFF6aa6f8),
      ),
      //
    ),
    style: TextStyle(color: Colors.white),
  );
}

Widget myHealthCoverages(String coverageName, IconData coverageIcon) {
  return FractionallySizedBox(
    widthFactor: 0.33,
    child: AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.only(
          right: 15.0,
          bottom: 15.0,
        ),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Color(0xFFe9f0f3),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                coverageIcon,
                size: 35,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 7.5,
                ),
                child: Text(
                  coverageName,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget sectionTitle(context, String title) {
  return Container(
    margin: const EdgeInsets.only(
      top: 20.0,
      left: 20.0,
      right: 20.0,
      bottom: 20.0,
    ),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.green.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: Divider(
            color: Colors.black12,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
    ),
  );
}

Widget doctorCard(
    {String firstName,
    String lastName,
    String prefix,
    String specialty,
    String imagePath,
    num rank,
    BuildContext context}) {
  return Container(
    margin: const EdgeInsets.only(
      left: 20.0,
      right: 20.0,
      top: 10.0,
    ),
    child: Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      color: Colors.white,
      child: new InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        onTap: () {

        },
        child: Container(
          child: Align(
            alignment: FractionalOffset.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: 20.0,
                    ),
                    width: 70.0,
                    height: 70.0,
                    child: (imagePath != null)
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(imagePath) ?? "",
                          )
                        : CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'assets/images/user.jpg',
                            ),
                          ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            '${prefix.capitalize()} ${firstName.capitalize()} ${lastName.capitalize()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF6f6f6f),
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 5.0,
                            ),
                            child: Text(
                              specialty,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9f9f9f),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 5.0,
                            ),
                            child: StarRating(
                              rating: rank,
                              rowAlignment: MainAxisAlignment.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
