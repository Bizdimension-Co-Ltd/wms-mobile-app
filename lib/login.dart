import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter layout demo', home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    width: double.infinity,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const Text(
                          "Warehouse Management System mobile",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              height: 1.7),
                        ),
                        const SizedBox(
                          height: 65,
                        ),
                        const Text(
                          "SIGN IN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: ' Name',
                            border: OutlineInputBorder(),
                            hintText: 'Enter Name',
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            hintText: 'Enter Password',
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 47.0,
                          child: ElevatedButton(
                            onPressed:
                                null, // Replace null with your actual callback function
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 17, 29, 38)),
                            ),
                            child: const Text(
                              'SIGN IN',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                          SizedBox(
                          width: double.infinity,
                          height: 47.0,
                          child: ElevatedButton(
                            onPressed:
                                null, // Replace null with your actual callback function
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 255, 255, 255)),
                            ),
                            child: const Text(
                              'Setting',
                              style: TextStyle(color: Color.fromARGB(255, 1, 1, 1)),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Copyright@ 2023 BizDimension Cambodia",
                      style: TextStyle(fontSize: 14.5, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "All right reserved",
                      style: TextStyle(fontSize: 14.5, color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
// Scaffold(
//       body: Container(
//         color: Colors.white,
//         width: MediaQuery.of(context).size.width,
//         height: 720,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 5,
//                 child: SizedBox(
//                     width: double.infinity,
//                     child: Container(
//                       padding: const EdgeInsets.all(40),
//                       width: double.infinity,
//                       // color: Colors.red,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             height: 100,
//                           ),
//                           const Text(
//                             "Warehouse Management System mobile",
//                             style: TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 height: 1.7),
//                           ),
//                           const SizedBox(
//                             height: 70,
//                           ),
//                           const Text(
//                             "SIGN IN",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 19),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           const TextField(
//                             decoration: InputDecoration(
//                               labelText: ' Name',
//                               border: OutlineInputBorder(),
//                               hintText: 'Enter Name',
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 25,
//                           ),
//                           const TextField(
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               border: OutlineInputBorder(),
//                               hintText: 'Enter Password',
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 40,
//                           ),
//                           SizedBox(
//                             width: double.infinity,
//                             height: 47.0,
//                             child: ElevatedButton(
//                               onPressed:
//                                   null, // Replace null with your actual callback function
//                               style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all(
//                                     const Color.fromARGB(255, 17, 29, 38)),
//                               ),
//                               child: const Text(
//                                 'SIGN IN',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Text(
//                         "Copyright@ 2023 BizDimension Cambodia",
//                         style: TextStyle(fontSize: 14.5, color: Colors.grey),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "All right reserved",
//                         style: TextStyle(fontSize: 14.5, color: Colors.grey),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );