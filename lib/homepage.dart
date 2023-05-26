import 'package:campus_assist_web/Campus%20Announcements/annoucements_list_screen.dart';
import 'package:campus_assist_web/Library/listview.dart';
import 'package:campus_assist_web/images/square_grid_tile.dart';
import 'package:campus_assist_web/results/resultsMainScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campus_assist_web/Library/Lib_Upload.dart';
import 'package:campus_assist_web/Campus Announcements/upload_post.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(
            image: const AssetImage('lib/images/app_logo.png'),
            width: 80,
            height: 80,
          ),
          Text('Campus Assist Academics',
              style: GoogleFonts.aBeeZee(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: const AssetImage('lib/images/doodle_bg.png'),
                    fit: BoxFit.cover),
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareGridTile(
                        logo: AssetImage('lib/images/library_logo.png'),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => homelist()),
                        ),
                        title: 'Library',
                      ),
                      SquareGridTile(
                        logo: AssetImage('lib/images/results_logo.png'),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CoursePage(),
                        )),
                        title: 'Upload Results',
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareGridTile(
                        logo: AssetImage('lib/images/announce_logo.png'),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AnnoucementScreen()),
                        ),
                        title: 'Campus Announcements',
                      ),
                      SquareGridTile(
                        logo: AssetImage('lib/images/contacts_logo.png'),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AnnoucementScreen()),
                        ),
                        title: 'Campus Contacts',
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
