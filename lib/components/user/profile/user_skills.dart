import 'package:flutter/material.dart';
import 'package:jobfinder/components/styles.dart';

class UserSkills extends StatefulWidget {
  const UserSkills({Key? key}) : super(key: key);

  @override
  State<UserSkills> createState() => _UserSkillsState();
}

class _UserSkillsState extends State<UserSkills> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              blackHeadingSmall('Skills'.toUpperCase()),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: Column(
              children: [
                textFieldNo('Home Address'),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('ADD'),
                        onPressed: (){
                          showModalBottomSheet(context: context, builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                              height: MediaQuery.of(context).size.height * .60,
                              child : Column(
                                children: [
                                  textFieldNo('Skills and Abilities'),
                                  SizedBox(height: 40,),
                                  ElevatedButton(
                                      onPressed: (){},
                                      child: Text("SAVE")),

                                ],


                              ),

                            );
                          }
                          );
                        },
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 10),
              ],
            )),
      ],
    );
  }
}
