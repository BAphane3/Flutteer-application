import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
try{
  final prefs = await SharedPreferences.getInstance();

  final role = prefs.getString('role');

  Widget startingScreen;

  if (role == 'student') {
    final studentName =
        prefs.getString('studentName') ?? '';

    final studentId =
        prefs.getString('studentId') ?? '';

    startingScreen = StudentMainScreen(
      studentName: studentName,
      studentId: studentId,
    );
  } else if (role == 'educator') {
    startingScreen = const EducatorMainScreen();
  } else {
    startingScreen = const WelcomeScreen();
  }


  runApp(
    MyApp(
      startingScreen: startingScreen,
    ),
  );
} catch (error) {
  print('Error initializing app: $error');

  runApp(
    const MyApp(
      startingScreen: WelcomeScreen(),
    ),
  );
}
}
class MyApp extends StatelessWidget {
  final Widget startingScreen;

  const MyApp({
    super.key,
    required this.startingScreen,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startingScreen,
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? selectedRole;

  void _selectRole(String role) {
    setState(() {
      selectedRole = role;
    });
  }

 void _continue() {
  final role = selectedRole;

  if (role == null) {
    return;
  }

  if (role == 'Student') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const StudentRegistrationScreen(),
      ),
    );
  } else if (role == 'Educator') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EducatorLoginScreen(),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'GENERATION SCHOOLS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Choose how you will use the Generation Schools app',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'What are you?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedRole == 'Student'
                              ? Colors.blue
                              : Colors.grey.shade200,
                      foregroundColor:
                          selectedRole == 'Student'
                              ? Colors.white
                              : Colors.black87,
                      side: BorderSide(
                        color:
                            selectedRole == 'Student'
                                ? Colors.blue
                                : Colors.grey.shade400,
                        width:
                            selectedRole == 'Student'
                                ? 2
                                : 1,
                      ),
                      minimumSize: const Size(
                        double.infinity,
                        70,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _selectRole('Student');
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.school),
                        const SizedBox(width: 12),
                        const Text(
                          'Student',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        if (selectedRole == 'Student')
                          const Icon(Icons.check_circle),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedRole == 'Educator'
                              ? Colors.blue
                              : Colors.grey.shade200,
                      foregroundColor:
                          selectedRole == 'Educator'
                              ? Colors.white
                              : Colors.black87,
                      side: BorderSide(
                        color:
                            selectedRole == 'Educator'
                                ? Colors.blue
                                : Colors.grey.shade400,
                        width:
                            selectedRole == 'Educator'
                                ? 2
                                : 1,
                      ),
                      minimumSize: const Size(
                        double.infinity,
                        70,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _selectRole('Educator');
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(width: 12),
                        const Text(
                          'Educator',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        if (selectedRole == 'Educator')
                          const Icon(Icons.check_circle),
                      ],
                    ),
                  ),

                  const Spacer(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF0B3557),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          Colors.grey.shade300,
                      disabledForegroundColor:
                          Colors.grey.shade600,
                      minimumSize: const Size(
                        double.infinity,
                        60,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed:
                        selectedRole == null
                            ? null
                            : _continue,
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentRegistrationScreen extends StatefulWidget {

  const StudentRegistrationScreen({super.key,});

  @override
  State<StudentRegistrationScreen> createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final nameController = TextEditingController();
  final studentIdController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    studentIdController.dispose();
    super.dispose();
  }

  Future<void> _registerStudent() async {
    final name = nameController.text.trim();
    final studentId = studentIdController.text.trim();

    if (name.isEmpty || studentId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }
    final nameParts = name.split(RegExp(r'\s+'));

    if (nameParts.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter your name and surname.'),
      ),
    );
    return;
  }

    if (!RegExp(r'^\d{5}$').hasMatch(studentId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student ID must be exactly 5 numbers.'),
        ),
      );
      return;
    }
  try{
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('role', 'student');
    await prefs.setString('studentName', name);
    await prefs.setString('studentId', studentId);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Registration successful for $name.',
        ),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => StudentMainScreen(
          studentName: name,
          studentId: studentId,
        ),
      ),
    );
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Something went wrong. Please try again.',
        ),
      ),
    );
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GENERATION SCHOOLS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Student Registration',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Please fill in your details below.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: const Icon(Icons.person_outline),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    TextField(
                      controller: studentIdController,
                      decoration: InputDecoration(
                        labelText: 'Student ID Number',
                        prefixIcon: const Icon(Icons.badge_outlined),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B3557),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(
                          double.infinity,
                          60,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _registerStudent,
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StudentUpdatesScreen extends StatelessWidget {
  const StudentUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Updates',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Stay up to date with school news',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // UPDATE CARDS
          Expanded(
  child: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('updates')
        .orderBy('createdAt', descending: true)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshot.hasError) {
        return const Center(
          child: Text('Something went wrong.'),
        );
      }

      final updates = snapshot.data?.docs ?? [];

      if (updates.isEmpty) {
        return const Center(
          child: Text('No updates available.'),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: updates.length,
        itemBuilder: (context, index) {
          final update = updates[index];

          final data = update.data() as Map<String, dynamic>;

          final title = data['title'] ?? 'No title';
          final message = data['message'] ?? 'No message';

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UpdateDetailScreen(
                      title: title,
                      message: message,
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    },
  ),
),
        ],
      ),
    );
  }
}
class UpdateDetailScreen extends StatelessWidget {
  final String title;
  final String message;

  const UpdateDetailScreen({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
class StudentMainScreen extends StatefulWidget {
  final String studentName;
  final String studentId;

  const StudentMainScreen({
    super.key,
    required this.studentName,
    required this.studentId,
  });

  @override
  State<StudentMainScreen> createState() =>
      _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  int selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const StudentUpdatesScreen(),
      StudentMotivationScreen(
        studentName: widget.studentName,
        studentId: widget.studentId,
      ),
      const StudentCalendarScreen(),
      StudentSettingsScreen(
        studentName: widget.studentName,
        studentId: widget.studentId,
      ),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: changePage,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Motivation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
class StudentMotivationScreen extends StatefulWidget {
  final String studentName;
  final String studentId;

  const StudentMotivationScreen({
    super.key,
    required this.studentName,
    required this.studentId,
  });
  

  @override
  State<StudentMotivationScreen> createState() =>
      _StudentMotivationScreenState();
}

class _StudentMotivationScreenState
    extends State<StudentMotivationScreen> {
  String? selectedMotivation; 

  void selectMotivation(String motivation) {
    setState(() {
      selectedMotivation = motivation;
    });
  }

  Future<void> _saveMotivation() async {
    try {
      if (selectedMotivation == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a motivation level.'),
          ),
        );
        return;
      }

      final now = DateTime.now();
      final todayKey = '${now.year}-${now.month}-${now.day}';

      final existingRecord = await FirebaseFirestore.instance
          .collection('motivation')
          .where('studentId', isEqualTo: widget.studentId)
          .where('dateKey', isEqualTo: todayKey)
          .limit(1)
          .get();

      if (existingRecord.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('motivation').add({
          'studentName': widget.studentName,
          'studentId': widget.studentId,
          'level': selectedMotivation,
          'dateKey': todayKey,
          'createdAt': Timestamp.now(),
        });

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Motivation saved successfully.'),
          ),
        );
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Motivation level already recorded for today.'),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Motivation',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'How are you feeling today?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Select your motivation level:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedMotivation == 'Very Good'
                            ? Colors.blue
                            : Colors.grey.shade200,
                    foregroundColor:
                        selectedMotivation == 'Very Good'
                            ? Colors.white
                            : Colors.black87,
                    minimumSize: const Size(
                      double.infinity,
                      65,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    selectMotivation('Very Good');
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.sentiment_very_satisfied,
                      color: Colors.green,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Very Good',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,                
                        ),
                      ),
                      const Spacer(),
                      if (selectedMotivation == 'Very Good')
                        const Icon(Icons.check_circle),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedMotivation == 'Good'
                            ? Colors.blue
                            : Colors.grey.shade200,
                    foregroundColor:
                        selectedMotivation == 'Good'
                            ? Colors.white
                            : Colors.black87,
                    minimumSize: const Size(
                      double.infinity,
                      65,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    selectMotivation('Good');
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.sentiment_satisfied,
                      color: Colors.lightGreenAccent,
                      
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Good',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (selectedMotivation == 'Good')
                        const Icon(Icons.check_circle),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedMotivation == 'Moderate'
                            ? Colors.blue
                            : Colors.grey.shade200,
                    foregroundColor:
                        selectedMotivation == 'Moderate'
                            ? Colors.white
                            : Colors.black87,
                    minimumSize: const Size(
                      double.infinity,
                      65,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    selectMotivation('Moderate');
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.sentiment_neutral,
                      color: Colors.yellow,
                      
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Moderate',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (selectedMotivation == 'Moderate')
                        const Icon(Icons.check_circle),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedMotivation == 'Low'
                            ? Colors.blue
                            : Colors.grey.shade200,
                    foregroundColor:
                        selectedMotivation == 'Low'
                            ? Colors.white
                            : Colors.black87,
                    minimumSize: const Size(
                      double.infinity,
                      65,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    selectMotivation('Low');
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.sentiment_dissatisfied,
                      color: Colors.orange,
                      
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Low',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (selectedMotivation == 'Low')
                        const Icon(Icons.check_circle),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedMotivation == 'Very Low'
                            ? Colors.blue
                            : Colors.grey.shade200,
                    foregroundColor:
                        selectedMotivation == 'Very Low'
                            ? Colors.white
                            : Colors.black87,
                    minimumSize: const Size(
                      double.infinity,
                      65,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    selectMotivation('Very Low');
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Very Low',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (selectedMotivation == 'Very Low')
                        const Icon(Icons.check_circle),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B3557),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    disabledForegroundColor: Colors.grey.shade600,
                    minimumSize: const Size(
                      double.infinity,
                      60,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _saveMotivation,
                  child: const Text(
                    'Save motivation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  final String details;

  Event({
    required this.title,
    required this.details,
  });
}

class StudentCalendarScreen extends StatefulWidget {
  const StudentCalendarScreen({super.key});
  

  @override
  State<StudentCalendarScreen> createState() =>
      _StudentCalendarScreenState();
}

class _StudentCalendarScreenState
    extends State<StudentCalendarScreen> {

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime _normalizedDate(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calendar',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'View upcoming school events',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('events')
                  .orderBy('date')
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Something went wrong.',
                    ),
                  );
                }

                final documents =
                    snapshot.data?.docs ?? [];

                final Map<DateTime, List<Event>>
                    events = {};

                for (final document in documents) {
                  final data =
                      document.data()
                          as Map<String, dynamic>;

                  final title =
                      data['title'] ?? 'No title';

                  final details =
                      data['details'] ?? 'No details';

                  final timestamp =
                      data['date'] as Timestamp?;

                  if (timestamp == null) {
                    continue;
                  }

                  final date = _normalizedDate(
                    timestamp.toDate(),
                  );

                  events.putIfAbsent(
                    date,
                    () => [],
                  );

                  events[date]!.add(
                    Event(
                      title: title,
                      details: details,
                    ),
                  );
                }

                final monthlyEvents =
                    events.entries.where(
                  (entry) {
                    return entry.key.year ==
                            _focusedDay.year &&
                        entry.key.month ==
                            _focusedDay.month;
                  },
                ).toList();

                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const Text(
                      'Upcoming Events:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TableCalendar(
                      firstDay: DateTime.utc(
                        2020,
                        1,
                        1,
                      ),
                      lastDay: DateTime.utc(
                        2030,
                        12,
                        31,
                      ),
                      focusedDay: _focusedDay,

                      selectedDayPredicate: (day) {
                        return isSameDay(
                          day,
                          _selectedDay,
                        );
                      },

                      eventLoader: (day) {
                        return events[
                                _normalizedDate(day)] ??
                            [];
                      },

                      onDaySelected:
                          (selected, focused) {
                        setState(() {
                          _selectedDay = selected;
                          _focusedDay = focused;
                        });
                      },

                      onPageChanged: (focused) {
                        setState(() {
                          _focusedDay = focused;
                        });
                      },

                      calendarStyle:
                          const CalendarStyle(
                        selectedDecoration:
                            BoxDecoration(
                          color: Color(0xFF0B3557),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration:
                            BoxDecoration(
                          color: Colors.blueGrey,
                          shape: BoxShape.circle,
                        ),
                        markerDecoration:
                            BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),

                      headerStyle:
                          const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Upcoming Events for this month:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (monthlyEvents.isEmpty)
                      const Text(
                        'No events for this month.',
                      )
                    else
                      for (final entry
                          in monthlyEvents)
                        for (final event
                            in entry.value)
                          Card(
                            margin:
                                const EdgeInsets.only(
                              bottom: 12,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                12,
                              ),
                            ),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.all(
                                16,
                              ),
                              leading: const Icon(
                                Icons.event,
                                color: Color(
                                  0xFF0B3557,
                                ),
                              ),
                              title: Text(
                                event.title,
                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.only(
                                  top: 6,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      '${entry.key.day}/'
                                      '${entry.key.month}/'
                                      '${entry.key.year}',
                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 4,
                                    ),

                                    Text(
                                      event.details,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  final String studentName;
  final String studentId;

  const FeedbackScreen({
    super.key,
    required this.studentName,
    required this.studentId,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController =
      TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
  final feedback = _feedbackController.text.trim();

  if (feedback.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter your feedback.'),
      ),
    );
    return;
  }
try{
  await FirebaseFirestore.instance
      .collection('feedback')
      .add({
    'studentName': widget.studentName,
    'studentId': widget.studentId,
    'feedback': feedback,
    'createdAt': Timestamp.now(),
  });

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Thank you. Your feedback has been submitted.',
      ),
    ),
  );

  _feedbackController.clear();

  Navigator.pop(context);
  } catch (error) {

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Something went wrong. Please try again.',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(
            Icons.feedback_outlined,
            size: 60,
            color: Color(0xFF0B3557),
          ),

          const SizedBox(height: 20),

          const Text(
            'We would love to hear from you',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Tell us about your experience using the app.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 30),

          TextField(
            controller: _feedbackController,
            maxLines: 6,
            decoration: InputDecoration(
              labelText: 'Your feedback',
              hintText: 'Write your feedback here...',
              filled: true,
              fillColor: Colors.white,
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B3557),
              foregroundColor: Colors.white,
              minimumSize: const Size(
                double.infinity,
                60,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _submitFeedback,
            child: const Text(
              'Submit Feedback',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  final String studentName;
  final String studentId;

  const StudentProfileScreen({
    super.key,
    required this.studentName,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.account_circle_outlined,
              size: 80,
              color: Color(0xFF0B3557),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Student Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ProfileRow(label: 'Name', value: studentName),
                    const SizedBox(height: 12),
                    _ProfileRow(label: 'Student ID', value: studentId),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class StudentSettingsScreen extends StatefulWidget {
  final String studentName;
  final String studentId;
  const StudentSettingsScreen({super.key, required this.studentName, required this.studentId});

  @override
  State<StudentSettingsScreen> createState() =>
      _StudentSettingsScreenState();
}

class _StudentSettingsScreenState extends State<StudentSettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Manage your preferences',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Card(
                  child: ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Profile'),
                    subtitle: Text('View your student information'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentProfileScreen(
                            studentName: widget.studentName,
                            studentId: widget.studentId,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Card(
                  child: SwitchListTile(
                    secondary: Icon(Icons.notifications_outlined),
                    title: Text('Notifications'),
                    subtitle: Text('Receive notifications'),
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                ),

                SizedBox(height: 12),

                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.feedback_outlined,
                    ),
                    title: const Text('Feedback'),
                    subtitle: const Text(
                      'Send us feedback about the app',
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackScreen(
                            studentName: widget.studentName,
                            studentId: widget.studentId,
                          ),
                        ),
                       );
                    },
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      await prefs.clear();

                      if (!mounted) return;

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WelcomeScreen(),
                        ),
                        (route) => false,
                        );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Educator login screen
class EducatorLoginScreen extends StatefulWidget {
  const EducatorLoginScreen({super.key});

  @override
  State<EducatorLoginScreen> createState() =>
      _EducatorLoginScreenState();
}

class _EducatorLoginScreenState
    extends State<EducatorLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginEducator() async {
    try {
      final email = emailController.text.trim().toLowerCase();
      final code = passwordController.text.trim();

      if (email.isEmpty || code.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields.'),
          ),
        );
        return;
      }

      if (!email.endsWith('@generationschools.com')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please use a valid Generation Schools email address.',
            ),
          ),
        );
        return;
      }

      if (code != '12345678910') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Incorrect educator access code.'),
          ),
        );
        return;
      }
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('role', 'educator');
      await prefs.setString('educatorEmail', email);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const EducatorMainScreen(),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GENERATION SCHOOLS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Educator Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sign in using your school credentials',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Please enter your Generation Schools email address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'name.surname@generationschools.com',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Enter educator access code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter access code',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B3557),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(
                      double.infinity,
                      60,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  
                  onPressed: _loginEducator,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EducatorMainScreen extends StatefulWidget {
  const EducatorMainScreen({super.key});

  @override
  State<EducatorMainScreen> createState() =>
      _EducatorMainScreenState();
}

class _EducatorMainScreenState
    extends State<EducatorMainScreen> {
  int selectedIndex = 0;
  String educatorName = 'Educator';
  String educatorEmail = 'educator@generationschools.com';

  @override
  void initState() {
    super.initState();
    _loadEducatorProfile();
  }

  Future<void> _loadEducatorProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('educatorEmail') ?? educatorEmail;
    final savedName = prefs.getString('educatorName');

    String resolvedName = savedName ?? 'Educator';
    if (savedName == null && savedEmail.contains('@')) {
      final localPart = savedEmail.split('@').first;
      final nameParts = localPart.split('.');
      resolvedName = nameParts
          .map((part) => part.isEmpty
              ? ''
              : '${part[0].toUpperCase()}${part.substring(1)}')
          .join(' ');
    }

    if (!mounted) return;

    setState(() {
      educatorName = resolvedName;
      educatorEmail = savedEmail;
    });
  }

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const EducatorUpdatesScreen(),
      const EducatorMotivationScreen(),
      const EducatorCalendarScreen(),
      EducatorSettingsScreen(
        educatorName: educatorName,
        educatorEmail: educatorEmail,
      ),
    ];

    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: changePage,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Motivation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
class EducatorUpdatesScreen extends StatelessWidget {
  const EducatorUpdatesScreen({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Updates',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Manage school updates',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('updates')
                  .orderBy(
                    'createdAt',
                    descending: true,
                  )
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Something went wrong.',
                    ),
                  );
                }

                final updates =
                    snapshot.data?.docs ?? [];

                if (updates.isEmpty) {
                  return const Center(
                    child: Text(
                      'No updates available.',
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: updates.length,
                  itemBuilder: (context, index) {
                    final update = updates[index];

                    final data =
                        update.data()
                            as Map<String, dynamic>;

                    final title =
                        data['title'] ?? 'No title';

                    final message =
                        data['message'] ?? 'No message';

                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: ListTile(
                        title: Text(
                          title,
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          message,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  UpdateDetailScreen(
                                title: title,
                                message: message,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF0B3557),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Create Update'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const EducatorCreateUpdateScreen(),
            ),
          );
        },
      ),
    );
  }
}
class EducatorCreateUpdateScreen extends StatefulWidget {
  const EducatorCreateUpdateScreen({super.key});

  @override
  State<EducatorCreateUpdateScreen> createState() =>
      _EducatorCreateUpdateScreenState();
}

class _EducatorCreateUpdateScreenState
    extends State<EducatorCreateUpdateScreen> {
  final titleController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> _sendUpdate() async {
    final title = titleController.text.trim();
    final message = messageController.text.trim();

    if (title.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }
  try {
    await FirebaseFirestore.instance
        .collection('updates')
        .add({
      'title': title,
      'message': message,
      'createdAt': Timestamp.now(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Update sent successfully.'),
      ),
    );

    titleController.clear();
    messageController.clear();
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Something went wrong. Please try again.',
        ),
      ),
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Create Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Update title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: messageController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Update message',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3557),
                foregroundColor: Colors.white,
                minimumSize: const Size(
                  double.infinity,
                  60,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _sendUpdate,
              child: const Text(
                'Send Update',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class EducatorMotivationScreen extends StatefulWidget {
  const EducatorMotivationScreen({super.key});

  @override
  State<EducatorMotivationScreen> createState() =>
      _EducatorMotivationScreenState();
}

class _EducatorMotivationScreenState
    extends State<EducatorMotivationScreen> {
  DateTime selectedDate = DateTime.now();

  String getDateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateKey =
        getDateKey(selectedDate);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Motivation',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Daily motivation summary',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('motivation')
                  .where(
                    'dateKey',
                    isEqualTo: selectedDateKey,
                  )
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Something went wrong.',
                    ),
                  );
                }

                final motivationRecords =
                    snapshot.data?.docs ?? [];

                int veryGood = 0;
                int good = 0;
                int moderate = 0;
                int low = 0;
                int veryLow = 0;

                for (final record
                    in motivationRecords) {
                  final data =
                      record.data()
                          as Map<String, dynamic>;

                  final level = data['level'];

                  if (level == 'Very Good') {
                    veryGood++;
                  } else if (level == 'Good') {
                    good++;
                  } else if (level == 'Moderate') {
                    moderate++;
                  } else if (level == 'Low') {
                    low++;
                  } else if (level == 'Very Low') {
                    veryLow++;
                  }
                }

                final totalResponses =
                    veryGood +
                    good +
                    moderate +
                    low +
                    veryLow;

                return ListView(
                  padding:
                      const EdgeInsets.all(24),
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                      label: Text(
                        'Date: '
                        '${selectedDate.day}/'
                        '${selectedDate.month}/'
                        '${selectedDate.year}',
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Total Responses: $totalResponses',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _MotivationSummaryCard(
                      label: 'Very Good',
                      count: veryGood,
                      icon:
                          Icons.sentiment_very_satisfied,
                    ),

                    _MotivationSummaryCard(
                      label: 'Good',
                      count: good,
                      icon:
                          Icons.sentiment_satisfied,
                    ),

                    _MotivationSummaryCard(
                      label: 'Moderate',
                      count: moderate,
                      icon:
                          Icons.sentiment_neutral,
                    ),

                    _MotivationSummaryCard(
                      label: 'Low',
                      count: low,
                      icon:
                          Icons.sentiment_dissatisfied,
                    ),

                    _MotivationSummaryCard(
                      label: 'Very Low',
                      count: veryLow,
                      icon:
                          Icons.sentiment_very_dissatisfied,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MotivationSummaryCard extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;

  const _MotivationSummaryCard({
    required this.label,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF0B3557),
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class EducatorCalendarScreen extends StatefulWidget {
  const EducatorCalendarScreen({super.key});

  @override
  State<EducatorCalendarScreen> createState() =>
      _EducatorCalendarScreenState();
}

class _EducatorCalendarScreenState

    extends State<EducatorCalendarScreen> {
      final eventTitleController = TextEditingController();
      final eventDetailsController = TextEditingController();

      @override
      void dispose() {
        eventTitleController.dispose();
        eventDetailsController.dispose();
        super.dispose();
     }

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime _normalizedDate(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  Future<void> _addEventToFirebase({
    required String title,
    required String details,
    required DateTime date,
  }) async {
    try{
    await FirebaseFirestore.instance
        .collection('events')
        .add({
      'title': title,
      'details': details,
      'date': Timestamp.fromDate(date),
      'createdAt': Timestamp.now(),
    });
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Something went wrong. Please try again.',
        ),
      ),
    );
  }
  }

  Future<void> _showAddEventDialog() async {
  eventTitleController.clear();
  eventDetailsController.clear();
try{
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Add Event'),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Date: '
              '${_selectedDay.day}/'
              '${_selectedDay.month}/'
              '${_selectedDay.year}',
            ),

            const SizedBox(height: 16),

            TextField(
              controller: eventTitleController,
              decoration: const InputDecoration(
                labelText: 'Event title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: eventDetailsController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Event details',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Cancel'),
          ),

          ElevatedButton(
            onPressed: () async {
              final title =
                  eventTitleController.text.trim();

              final details =
                  eventDetailsController.text.trim();

              if (title.isEmpty || details.isEmpty) {
                return;
              }

              await _addEventToFirebase(
                title: title,
                details: details,
                date: _selectedDay,
              );

              if (!mounted) return;

              Navigator.pop(dialogContext);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Event added successfully.',
                  ),
                ),
              );
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
} catch (error) {
  if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Something went wrong. Please try again.',
        ),
      ),
    );
}
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Calendar',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  'View and manage school events',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // FIRESTORE CALENDAR DATA
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('events')
                  .orderBy('date')
                  .snapshots(),

              builder: (context, snapshot) {
                // WAITING FOR FIREBASE
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                // FIREBASE ERROR
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Something went wrong.',
                    ),
                  );
                }

                final documents =
                    snapshot.data?.docs ?? [];

                // We rebuild this map using
                // Firestore documents.
                final Map<DateTime, List<Event>>
                    events = {};

                for (final document
                    in documents) {
                  final data =
                      document.data()
                          as Map<String, dynamic>;

                  final title =
                      data['title'] ?? 'No title';

                  final details =
                      data['details'] ??
                          'No details';

                  final timestamp =
                      data['date'] as Timestamp?;

                  if (timestamp == null) {
                    continue;
                  }

                  final date = _normalizedDate(
                    timestamp.toDate(),
                  );

                  // If this date does not exist
                  // yet, create an empty list.
                  events.putIfAbsent(
                    date,
                    () => [],
                  );

                  // Add this event to its date.
                  events[date]!.add(
                    Event(
                      title: title,
                      details: details,
                    ),
                  );
                }

                // Find events for the month
                // currently being viewed.
                final monthlyEvents =
                    events.entries.where(
                  (entry) {
                    return entry.key.year ==
                            _focusedDay.year &&
                        entry.key.month ==
                            _focusedDay.month;
                  },
                ).toList();

                return ListView(
                  padding:
                      const EdgeInsets.all(24),
                  children: [
                    const Text(
                      'Upcoming Events:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TableCalendar(
                      firstDay:
                          DateTime.utc(2020, 1, 1),

                      lastDay:
                          DateTime.utc(
                            2030,
                            12,
                            31,
                          ),

                      focusedDay: _focusedDay,

                      selectedDayPredicate: (day) {
                        return isSameDay(
                          day,
                          _selectedDay,
                        );
                      },

                      // THIS IS WHERE THE CALENDAR
                      // GETS FIRESTORE EVENTS
                      eventLoader: (day) {
                        return events[
                                _normalizedDate(
                                  day,
                                )] ??
                            [];
                      },

                      onDaySelected:
                          (selected, focused) {
                        setState(() {
                          _selectedDay =
                              selected;

                          _focusedDay =
                              focused;
                        });
                      },

                      onPageChanged: (focused) {
                        setState(() {
                          _focusedDay =
                              focused;
                        });
                      },

                      calendarStyle:
                          const CalendarStyle(
                        selectedDecoration:
                            BoxDecoration(
                          color:
                              Color(0xFF0B3557),
                          shape:
                              BoxShape.circle,
                        ),

                        todayDecoration:
                            BoxDecoration(
                          color:
                              Colors.blueGrey,
                          shape:
                              BoxShape.circle,
                        ),

                        markerDecoration:
                            BoxDecoration(
                          color:
                              Colors.orange,
                          shape:
                              BoxShape.circle,
                        ),
                      ),

                      headerStyle:
                          const HeaderStyle(
                        formatButtonVisible:
                            false,
                        titleCentered: true,
                        titleTextStyle:
                            TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Upcoming Events for this month:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (monthlyEvents.isEmpty)
                      const Text(
                        'No events for this month.',
                      )
                    else
                      for (final entry
                          in monthlyEvents)
                        for (final event
                            in entry.value)
                          Card(
                            margin:
                                const EdgeInsets
                                    .only(
                              bottom: 12,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets
                                      .all(
                                16,
                              ),
                              leading:
                                  const Icon(
                                Icons.event,
                                color: Color(
                                  0xFF0B3557,
                                ),
                              ),
                              title: Text(
                                event.title,
                                style:
                                    const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                              subtitle:
                                  Padding(
                                padding:
                                    const EdgeInsets
                                        .only(
                                  top: 6,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      '${entry.key.day}/'
                                      '${entry.key.month}/'
                                      '${entry.key.year}',
                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .w600,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 4,
                                    ),

                                    Text(
                                      event.details,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor:
            const Color(0xFF0B3557),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Event'),
        onPressed: _showAddEventDialog,
      ),
    );
  }
}

class EducatorSettingsScreen extends StatefulWidget {
  final String educatorName;
  final String educatorEmail;

  const EducatorSettingsScreen({
    super.key,
    required this.educatorName,
    required this.educatorEmail,
  });

  @override
  State<EducatorSettingsScreen> createState() =>
      _EducatorSettingsScreenState();
}

class EducatorProfileScreen extends StatelessWidget {
  final String educatorName;
  final String educatorEmail;

  const EducatorProfileScreen({
    super.key,
    required this.educatorName,
    required this.educatorEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.account_circle_outlined,
              size: 80,
              color: Color(0xFF0B3557),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _ProfileRow(label: 'Name', value: educatorName),
                    const SizedBox(height: 12),
                    _ProfileRow(label: 'Email', value: educatorEmail),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EducatorSettingsScreenState extends State<EducatorSettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24,
              50,
              24,
              28,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3557),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Manage your preferences',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Profile'),
                    subtitle: const Text('View user information'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EducatorProfileScreen(
                            educatorName: widget.educatorName,
                            educatorEmail: widget.educatorEmail,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Card(
                  child: SwitchListTile(
                    secondary: Icon(Icons.notifications_outlined),
                    title: Text('Notifications'),
                    subtitle: Text('Receive notifications'),
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                ),

                SizedBox(height: 12),

                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.feedback_outlined,
                    ),
                    title: const Text('Feedback'),
                    subtitle: const Text(
                      'Send us feedback about the app',
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EducatorFeedbackScreen(
                            educatorName: widget.educatorName,
                            educatorEmail: widget.educatorEmail,
                          ),
                        ),
                       );
                    },
                    
                  ),
                ),

                SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      await prefs.clear();

                      if (!mounted) return;

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WelcomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EducatorFeedbackScreen extends StatefulWidget {
  const EducatorFeedbackScreen({
    super.key,
    required this.educatorName,
    required this.educatorEmail,
  });

  final String educatorName;
  final String educatorEmail;

  @override
  State<EducatorFeedbackScreen> createState() => _EducatorFeedbackScreenState();
}

class _EducatorFeedbackScreenState extends State<EducatorFeedbackScreen> {
  final TextEditingController _feedbackController =
      TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
  final feedback = _feedbackController.text.trim();

  if (feedback.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter your feedback.'),
      ),
    );
    return;
  }
try {
  await FirebaseFirestore.instance
      .collection('feedback')
      .add({
    'studentName': widget.educatorName,
    'studentId': widget.educatorEmail,
    'feedback': feedback,
    'createdAt': Timestamp.now(),
  });

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Thank you. Your feedback has been submitted.',
      ),
    ),
  );

  _feedbackController.clear();

  Navigator.pop(context);
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Something went wrong. Please try again.',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(
            Icons.feedback_outlined,
            size: 60,
            color: Color(0xFF0B3557),
          ),

          const SizedBox(height: 20),

          const Text(
            'We would love to hear from you',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Tell us about your experience using the app.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 30),

          TextField(
            controller: _feedbackController,
            maxLines: 6,
            decoration: InputDecoration(
              labelText: 'Your feedback',
              hintText: 'Write your feedback here...',
              filled: true,
              fillColor: Colors.white,
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B3557),
              foregroundColor: Colors.white,
              minimumSize: const Size(
                double.infinity,
                60,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _submitFeedback,
            child: const Text(
              'Submit Feedback',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}