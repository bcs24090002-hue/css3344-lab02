import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  static const List<String> _roles = ['Student', 'Developer', 'Designer'];

  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Student';

  Future<void> _selectMaterialDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _showCupertinoDatePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) => Container(
        height: 280,
        color: CupertinoColors.systemBackground.resolveFrom(popupContext),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                onPressed: () => Navigator.of(popupContext).pop(),
                child: const Text('Done'),
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                minimumDate: DateTime(1950),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() => _selectedDate = newDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCupertinoRolePicker() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(popupContext),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                onPressed: () => Navigator.of(popupContext).pop(),
                child: const Text('Done'),
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 40,
                scrollController: FixedExtentScrollController(
                  initialItem: _roles.indexOf(_selectedRole),
                ),
                onSelectedItemChanged: (int index) {
                  setState(() => _selectedRole = _roles[index]);
                },
                children: _roles
                    .map((role) => Center(child: Text(role)))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _formattedDate {
    final String month = _selectedDate.month.toString().padLeft(2, '0');
    final String day = _selectedDate.day.toString().padLeft(2, '0');
    return '${_selectedDate.year}-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.portrait
            ? _buildPortraitView()
            : _buildLandscapeView(),
      ),
    );
  }

  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const StudentProfileCard(),
        const SizedBox(height: 16),
        const TitleSection(
          name: 'Oeschinen Lake',
          location: 'Kandersteg, Switzerland',
          starCount: 41,
        ),
        const ImageSection(imagePath: 'assets/images/lake.jpg'),
        const ActionButtonsSection(),
        const TextSection(
          description:
              'Lake Oeschinen lies in the Bernese Alps above Kandersteg. '
              'Its clear alpine water and mountain scenery make it a popular '
              'place for hiking, rowing, and enjoying the outdoors.',
        ),
        PickerSection(
          formattedDate: _formattedDate,
          selectedRole: _selectedRole,
          roles: _roles,
          onMaterialDateTap: _selectMaterialDate,
          onCupertinoDateTap: _showCupertinoDatePicker,
          onRoleChanged: (role) => setState(() => _selectedRole = role),
          onCupertinoRoleTap: _showCupertinoRolePicker,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 4,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: StudentProfileCard(),
          ),
        ),
        Expanded(
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
            children: [
              const TitleSection(
                name: 'Oeschinen Lake',
                location: 'Kandersteg, Switzerland',
                starCount: 41,
              ),
              const ImageSection(imagePath: 'assets/images/lake.jpg'),
              const ActionButtonsSection(),
              const TextSection(
                description:
                    'Lake Oeschinen lies in the Bernese Alps above Kandersteg. '
                    'Its clear alpine water and mountain scenery make it a '
                    'popular place for hiking, rowing, and enjoying the outdoors.',
              ),
              PickerSection(
                formattedDate: _formattedDate,
                selectedRole: _selectedRole,
                roles: _roles,
                onMaterialDateTap: _selectMaterialDate,
                onCupertinoDateTap: _showCupertinoDatePicker,
                onRoleChanged: (role) => setState(() => _selectedRole = role),
                onCupertinoRoleTap: _showCupertinoRolePicker,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StudentProfileCard extends StatelessWidget {
  const StudentProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Card(
      color: colors.primary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 46,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(height: 14),
            Text(
              'YAP CHI SHIEN',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Student ID: BCS24090002',
              style: TextStyle(color: colors.onPrimary.withValues(alpha: 0.85)),
            ),
            Divider(color: colors.onPrimary.withValues(alpha: 0.4), height: 28),
            Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(
                color: colors.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '“Patient is key in life”',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onPrimary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  final String name;
  final String location;
  final int starCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(location, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        height: 220,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ActionButton(color: color, icon: Icons.call, label: 'CALL'),
          _ActionButton(color: color, icon: Icons.near_me, label: 'ROUTE'),
          _ActionButton(color: color, icon: Icons.share, label: 'SHARE'),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 20),
      child: Text(description, softWrap: true),
    );
  }
}

class PickerSection extends StatelessWidget {
  const PickerSection({
    super.key,
    required this.formattedDate,
    required this.selectedRole,
    required this.roles,
    required this.onMaterialDateTap,
    required this.onCupertinoDateTap,
    required this.onRoleChanged,
    required this.onCupertinoRoleTap,
  });

  final String formattedDate;
  final String selectedRole;
  final List<String> roles;
  final VoidCallback onMaterialDateTap;
  final VoidCallback onCupertinoDateTap;
  final ValueChanged<String> onRoleChanged;
  final VoidCallback onCupertinoRoleTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Interactive Pickers (Lab 2.2)',
                style: Theme.of(context).textTheme.titleMedium),
            const Divider(height: 24),
            Text('Selected Date: $formattedDate'),
            const SizedBox(height: 4),
            Text(
              'Selected Role: $selectedRole',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: onMaterialDateTap,
                  icon: const Icon(Icons.calendar_month),
                  label: const Text('Material Date Picker'),
                ),
                OutlinedButton.icon(
                  onPressed: onCupertinoDateTap,
                  icon: const Icon(Icons.date_range),
                  label: const Text('Cupertino Date Picker'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Flexible(child: Text('Material Dropdown:')),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedRole,
                  items: roles
                      .map((role) => DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) onRoleChanged(newValue);
                  },
                ),
              ],
            ),
            OutlinedButton.icon(
              onPressed: onCupertinoRoleTap,
              icon: const Icon(Icons.tune),
              label: const Text('Cupertino Role Wheel Picker'),
            ),
          ],
        ),
      ),
    );
  }
}
