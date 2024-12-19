import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// New page to display SGPA and CGPA
class ResultsPage extends StatelessWidget {
  final double cgpa;
  final List<double> sgpas;

  ResultsPage({required this.cgpa, required this.sgpas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 130,),
            Text(
              'CGPA: ${cgpa.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'SGPA for Each Semester:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 10),
            for (int i = 0; i < sgpas.length; i++)
              Text(
                'Semester ${i + 1}: SGPA = ${sgpas[i].toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

class SGPA_CGPA_Page extends StatefulWidget {
  @override
  _SGPA_CGPA_PageState createState() => _SGPA_CGPA_PageState();
}

class _SGPA_CGPA_PageState extends State<SGPA_CGPA_Page> {
  final List<Map<String, dynamic>> semesters = [];
  double cgpa = 0.0;

  @override
  void initState() {
    super.initState();
    _loadSemestersData();
  }

  // Load saved semester data from SharedPreferences
  Future<void> _loadSemestersData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedData = prefs.getStringList('semesters');

    if (savedData != null) {
      setState(() {
        semesters.clear();
        for (var semesterData in savedData) {
          List<String> parts = semesterData.split('|');
          semesters.add({
            'mid1': double.parse(parts[0]),
            'mid2': double.parse(parts[1]),
            'final': double.parse(parts[2]),
            'sgpa': double.parse(parts[3]),
          });
        }
      });
      _calculateCGPA();
    }
  }

  // Save semester data to SharedPreferences
  Future<void> _saveSemestersData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedData = [];

    for (var semester in semesters) {
      savedData.add(
          '${semester['mid1']}|${semester['mid2']}|${semester['final']}|${semester['sgpa']}');
    }

    prefs.setStringList('semesters', savedData);
  }

  // Add new semester
  void _addSemester() {
    setState(() {
      semesters.add({
        'mid1': 0.0,
        'mid2': 0.0,
        'final': 0.0,
        'sgpa': 0.0,
      });
    });
  }

  // Calculate SGPA for a given semester
  void _calculateSGPA(int index) {
    final mid1 = semesters[index]['mid1'];
    final mid2 = semesters[index]['mid2'];
    final finalExam = semesters[index]['final'];

    // Assuming weightages:
    double sgpa = (mid1 * 0.2) + (mid2 * 0.2) + (finalExam * 0.6);
    setState(() {
      semesters[index]['sgpa'] = sgpa;
    });
    _calculateCGPA();
  }

  // Calculate CGPA based on SGPA of all semesters
  void _calculateCGPA() {
    double totalSGPA = 0;
    for (var semester in semesters) {
      totalSGPA += semester['sgpa'];
    }

    setState(() {
      cgpa = totalSGPA / semesters.length;
    });
  }

  // Navigate to the ResultsPage and pass the calculated CGPA and SGPA
  void _navigateToResultsPage() {
    List<double> sgpas = semesters.map((e) => e['sgpa'] as double).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(cgpa: cgpa, sgpas: sgpas),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 90,),
            // CGPA Display
            Text(
              'CGPA: ${cgpa.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 20),
            // Semester List
            Expanded(
              child: ListView.builder(
                itemCount: semesters.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white60,
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Semester ${index + 1}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: 'Mid 1'),
                                  onChanged: (value) {
                                    setState(() {
                                      semesters[index]['mid1'] = double.tryParse(value) ?? 0.0;
                                    });
                                    _calculateSGPA(index);
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: 'Mid 2'),
                                  onChanged: (value) {
                                    setState(() {
                                      semesters[index]['mid2'] = double.tryParse(value) ?? 0.0;
                                    });
                                    _calculateSGPA(index);
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: 'Final'),
                                  onChanged: (value) {
                                    setState(() {
                                      semesters[index]['final'] = double.tryParse(value) ?? 0.0;
                                    });
                                    _calculateSGPA(index);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('SGPA: ${semesters[index]['sgpa'].toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Add Semester Button
            Row(
              children: [
                ElevatedButton(
                  onPressed: _addSemester,
                  child: Text('     Add Semester     ',style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  onPressed: _navigateToResultsPage,
                  child: Text('    View Results    ',style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            // View Results Button

          ],
        ),
      ),
    );
  }
}
