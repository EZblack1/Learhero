import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const LearnHeroApp());
}

class LearnHeroApp extends StatelessWidget {
  const LearnHeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LearnHero',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/home': (_) => const HomeDashboard(),
        '/lesson': (_) => const LessonScreen(),
        '/victory': (_) => const VictoryScreen(),
        '/leaderboard': (_) => const LeaderboardScreen(),
        '/profile': (_) => const ProfileScreen(),
      },
    );
  }
}

class AppColors {
  static const background = Color(0xFF12082A);
  static const card = Color(0xFF1E1040);
  static const primary = Color(0xFF6C3CE1);
  static const primaryDark = Color(0xFF4A1FAE);
  static const accent = Color(0xFFFFD43B);
  static const muted = Color(0xFFB8AED0);
  static const danger = Color(0xFFFF4757);
  static const success = Color(0xFF22C55E);
  static const cyan = Color(0xFF4ECDC4);
}

class AppFrame extends StatelessWidget {
  const AppFrame({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: child,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.enabled = true,
    this.secondary = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool enabled;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    final background = secondary ? AppColors.card : AppColors.accent;
    final foreground = secondary ? Colors.white : AppColors.background;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: enabled ? onPressed : null,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor: background.withValues(alpha: 0.45),
          disabledForegroundColor: foreground.withValues(alpha: 0.55),
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.gradient,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: padding,
          decoration: BoxDecoration(
            color: gradient == null ? AppColors.card : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class GradientCircle extends StatelessWidget {
  const GradientCircle({
    required this.child,
    this.size = 96,
    this.borderColor,
    super.key,
  });

  final Widget child;
  final double size;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        border: Border.all(color: borderColor ?? Colors.transparent, width: 4),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primaryDark],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.45),
                          blurRadius: 28,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 76,
                            height: 88,
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.bolt,
                              size: 52,
                              color: AppColors.background,
                            ),
                          ),
                          Positioned(
                            right: -12,
                            top: -12,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.background,
                                  width: 4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'LearnHero',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Aprenda. Evolua. Conquiste.',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 48),
                  GradientCircle(
                    size: 180,
                    borderColor: AppColors.primary,
                    child: Text(
                      heroAvatar,
                      style: const TextStyle(fontSize: 82),
                    ),
                  ),
                  const SizedBox(height: 48),
                  PrimaryButton(
                    label: 'Começar sua jornada',
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                  ),
                  const SizedBox(height: 28),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Dot(active: true), Dot(), Dot()],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({this.active = false, super.key});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: active ? AppColors.accent : Colors.white.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _controller = TextEditingController();
  final _subjects = <String>{};
  int _selectedAvatar = 0;

  static const avatars = ['🦸', '🧙', '🥷', '👨‍🚀'];
  static const subjects = [
    'Matemática',
    'Ciências',
    'História',
    'Idiomas',
    'Artes',
    'Tecnologia',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _controller.text.trim().isNotEmpty && _subjects.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text(
                'Crie seu Herói',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Escolha seu avatar e seus interesses',
                style: TextStyle(color: AppColors.muted, fontSize: 16),
              ),
              const SizedBox(height: 34),
              const SectionLabel('Escolha seu avatar'),
              const SizedBox(height: 14),
              GridView.builder(
                itemCount: avatars.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  final selected = index == _selectedAvatar;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedAvatar = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.card,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: selected
                              ? AppColors.accent
                              : Colors.transparent,
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          avatars[index],
                          style: const TextStyle(fontSize: 42),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const SectionLabel('Nome de usuário'),
              const SizedBox(height: 14),
              TextField(
                controller: _controller,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Digite o nome do seu herói',
                  hintStyle: const TextStyle(color: AppColors.muted),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const SectionLabel('O que você quer aprender?'),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: subjects.map((subject) {
                  final selected = _subjects.contains(subject);
                  return ChoiceChip(
                    label: Text(subject),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        selected
                            ? _subjects.remove(subject)
                            : _subjects.add(subject);
                      });
                    },
                    selectedColor: AppColors.accent,
                    backgroundColor: AppColors.card,
                    labelStyle: TextStyle(
                      color: selected ? AppColors.background : Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 44),
              PrimaryButton(
                label: 'Criar meu Herói',
                enabled: _canSubmit,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Modo de alto contraste disponível nas configurações',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Scaffold(
        body: Column(
          children: [
            const HomeHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 96),
                children: [
                  AppCard(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Missão diária',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Pill(
                              icon: Icons.local_fire_department,
                              label: 'Dia 12',
                              background: Colors.white.withValues(alpha: 0.18),
                              foreground: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Complete 3 aulas para manter sua sequência!',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        const SizedBox(height: 18),
                        const ProgressLine(value: 1 / 3),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppCard(
                    onTap: () => Navigator.pushNamed(context, '/lesson'),
                    child: Row(
                      children: [
                        const EmojiTile(emoji: '📚'),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Aventura Matemática',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Domine o básico de álgebra',
                                style: TextStyle(color: AppColors.muted),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '🎯 10 desafios  •  ⏱ 15 min',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const XpBadge('+50 XP'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      QuickAccessCard(
                        icon: Icons.menu_book,
                        title: 'Meus cursos',
                      ),
                      QuickAccessCard(
                        icon: Icons.track_changes,
                        title: 'Desafios',
                      ),
                      QuickAccessCard(
                        icon: Icons.emoji_events,
                        title: 'Ranking',
                        onTap: () =>
                            Navigator.pushNamed(context, '/leaderboard'),
                      ),
                      QuickAccessCard(
                        icon: Icons.card_giftcard,
                        title: 'Recompensas',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNav(currentPage: 'home'),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary,
                child: Text(heroAvatar, style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HeroiLegal42',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Estudante nível 7',
                      style: TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const Pill(
                label: 'Nível 7',
                background: AppColors.accent,
                foreground: AppColors.background,
              ),
            ],
          ),
          const SizedBox(height: 18),
          const ProgressLine(value: 0.65),
          const SizedBox(height: 8),
          const Text(
            '650 / 1000 XP para o nível 8',
            style: TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final _questions = const [
    QuizQuestion('Quanto é 7 x 8?', ['54', '56', '64', '48'], 1),
    QuizQuestion('Qual planeta fica mais perto do Sol?', [
      'Vênus',
      'Marte',
      'Mercúrio',
      'Terra',
    ], 2),
    QuizQuestion('Qual é a capital da França?', [
      'Londres',
      'Berlim',
      'Madri',
      'Paris',
    ], 3),
  ];

  int _current = 0;
  int? _selected;
  int _correct = 0;
  bool _showResult = false;

  QuizQuestion get _question => _questions[_current];

  Future<void> _selectAnswer(int index) async {
    if (_showResult) return;

    final isCorrect = index == _question.correct;
    setState(() {
      _selected = index;
      _showResult = true;
      if (isCorrect) _correct += 1;
    });

    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    if (_current < _questions.length - 1) {
      setState(() {
        _current += 1;
        _selected = null;
        _showResult = false;
      });
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/victory',
        arguments: VictoryResult(
          correctAnswers: _correct,
          total: _questions.length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_current + 1) / _questions.length;
    final selectedIsCorrect = _selected == _question.correct;

    return AppFrame(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
              decoration: const BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton.filled(
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/home'),
                        icon: const Icon(Icons.close),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Pergunta ${_current + 1} de ${_questions.length}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const XpBadge('+50 XP'),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ProgressLine(value: progress),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  GradientCircle(
                    size: 96,
                    child: Text(
                      _showResult
                          ? (selectedIsCorrect ? '🎉' : '🤔')
                          : heroAvatar,
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    _question.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 28),
                  ...List.generate(_question.options.length, (index) {
                    Color color = AppColors.card;
                    Color border = Colors.transparent;
                    if (_showResult && index == _question.correct) {
                      color = AppColors.success;
                      border = const Color(0xFF86EFAC);
                    } else if (_showResult && index == _selected) {
                      color = AppColors.danger;
                      border = const Color(0xFFFCA5A5);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Material(
                        color: color,
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          onTap: () => _selectAnswer(index),
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: border, width: 2),
                            ),
                            child: Text(
                              _question.options[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  if (_showResult)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        selectedIsCorrect
                            ? 'Mandou bem! 🎯'
                            : 'Quase! Tente a próxima! 💪',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VictoryScreen extends StatelessWidget {
  const VictoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final result = args is VictoryResult
        ? args
        : const VictoryResult(correctAnswers: 3, total: 3);
    final accuracy = (result.correctAnswers / result.total * 100).round();
    final xp = result.correctAnswers * 50;

    return AppFrame(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 24),
              GradientCircle(
                size: 128,
                borderColor: AppColors.accent,
                child: const Icon(
                  Icons.emoji_events,
                  color: AppColors.background,
                  size: 68,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Missão concluída!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 22),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    '+$xp XP',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const AppCard(
                child: Row(
                  children: [
                    EmojiTile(emoji: '🏛️'),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NOVA MEDALHA DESBLOQUEADA!',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Explorador de História',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              AppCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatItem(
                      icon: Icons.track_changes,
                      label: 'Precisão',
                      value: '$accuracy%',
                    ),
                    const StatItem(
                      icon: Icons.schedule,
                      label: 'Tempo',
                      value: '4:32',
                    ),
                    const StatItem(
                      icon: Icons.local_fire_department,
                      label: 'Sequência',
                      value: 'Dia 13',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              PrimaryButton(
                label: 'Continuar jornada',
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
              ),
              const SizedBox(height: 14),
              PrimaryButton(
                label: 'Compartilhar conquista',
                icon: Icons.share,
                secondary: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _tab = 'Geral';

  final _players = const [
    Player(1, '🧙', 'MestreMago99', 15420),
    Player(2, '👨‍🚀', 'ExploradorEspacial', 14850),
    Player(3, '🥷', 'NinjaSombrio', 13990),
    Player(4, heroAvatar, 'HeroiLegal42', 12650, currentUser: true),
    Player(5, '👩‍🔬', 'RainhaDaCiencia', 11230),
    Player(6, '🧙', 'ReiMago', 10890),
    Player(7, '👨‍🚀', 'JogadorCosmico', 9420),
    Player(8, '🥷', 'ProFurtivo', 8765),
  ];

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
              decoration: const BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Ranking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Pill(
                        label: 'Reinicia em 4d 12h',
                        background: Color(0x336C3CE1),
                        foreground: AppColors.accent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: ['Geral', 'Amigos', 'Escola'].map((tab) {
                      final selected = tab == _tab;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FilledButton(
                            onPressed: () => setState(() => _tab = tab),
                            style: FilledButton.styleFrom(
                              backgroundColor: selected
                                  ? AppColors.primary
                                  : AppColors.background.withValues(alpha: 0.5),
                              foregroundColor: selected
                                  ? Colors.white
                                  : AppColors.muted,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(tab),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 96),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PodiumCard(player: _players[1], height: 96),
                      const SizedBox(width: 10),
                      PodiumCard(player: _players[0], height: 128, first: true),
                      const SizedBox(width: 10),
                      PodiumCard(player: _players[2], height: 82),
                    ],
                  ),
                  const SizedBox(height: 26),
                  ..._players
                      .skip(3)
                      .map((player) => PlayerRow(player: player)),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNav(currentPage: 'map'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const badges = [
    BadgeInfo('🏛️', 'Explorador de História', true),
    BadgeInfo('🧮', 'Mestre da Matemática', true),
    BadgeInfo('🔬', 'Craque em Ciências', true),
    BadgeInfo('📚', 'Leitor dedicado', true),
    BadgeInfo('🎨', 'Mente criativa', true),
    BadgeInfo('🌍', 'Viajante do mundo', false),
    BadgeInfo('⚡', 'Aprendiz veloz', false),
    BadgeInfo('🎯', 'Pontuação perfeita', false),
    BadgeInfo('💎', 'Liga Diamante', false),
  ];

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
              decoration: const BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(Icons.settings),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const Column(
                    children: [
                      SizedBox(width: double.infinity),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GradientCircle(
                            size: 128,
                            borderColor: AppColors.accent,
                            child: Text(
                              heroAvatar,
                              style: TextStyle(fontSize: 62),
                            ),
                          ),
                          Positioned(
                            right: -10,
                            bottom: -10,
                            child: Pill(
                              label: 'Nível 7',
                              background: AppColors.accent,
                              foreground: AppColors.background,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        'HeroiLegal42',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: AppColors.muted,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Entrou em março de 2026',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 96),
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.track_changes,
                          value: '47',
                          label: 'Missões',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.emoji_events,
                          value: '5',
                          label: 'Medalhas',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: Icons.local_fire_department,
                          value: '13',
                          label: 'Sequência',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const ScreenTitle('Coleção de medalhas'),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: badges
                        .map((badge) => BadgeTile(badge: badge))
                        .toList(),
                  ),
                  const SizedBox(height: 28),
                  const ScreenTitle('Conquistas recentes'),
                  const SizedBox(height: 14),
                  const AchievementCard(
                    icon: '🏆',
                    title: 'Primeira vitória',
                    description: 'Completou sua primeira missão',
                    date: 'há 2 dias',
                  ),
                  const AchievementCard(
                    icon: '🔥',
                    title: 'Guerreiro da semana',
                    description: 'Manteve uma sequência de 7 dias',
                    date: 'há 5 dias',
                  ),
                  const AchievementCard(
                    icon: '⭐',
                    title: 'Estrela em ascensão',
                    description: 'Chegou ao nível 5',
                    date: 'há 1 semana',
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNav(currentPage: 'profile'),
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({required this.currentPage, super.key});

  final String currentPage;

  @override
  Widget build(BuildContext context) {
    final items = [
      NavItem('home', Icons.home, 'Início', '/home'),
      NavItem('quests', Icons.track_changes, 'Missões', '/lesson'),
      NavItem('map', Icons.map, 'Mapa', '/leaderboard'),
      NavItem('profile', Icons.person, 'Perfil', '/profile'),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            final selected = item.id == currentPage;
            return InkWell(
              onTap: () => Navigator.pushReplacementNamed(context, item.route),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: selected ? AppColors.accent : AppColors.muted,
                      size: selected ? 28 : 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        color: selected ? AppColors.accent : AppColors.muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({required this.value, super.key});

  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: LinearProgressIndicator(
        minHeight: 10,
        value: value,
        backgroundColor: AppColors.background.withValues(alpha: 0.55),
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
      ),
    );
  }
}

class Pill extends StatelessWidget {
  const Pill({
    required this.label,
    this.icon,
    this.background = AppColors.accent,
    this.foreground = AppColors.background,
    super.key,
  });

  final String label;
  final IconData? icon;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: AppColors.accent),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class XpBadge extends StatelessWidget {
  const XpBadge(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Pill(
      label: label,
      background: AppColors.accent,
      foreground: AppColors.background,
    );
  }
}

class EmojiTile extends StatelessWidget {
  const EmojiTile({required this.emoji, super.key});

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 30))),
    );
  }
}

class QuickAccessCard extends StatelessWidget {
  const QuickAccessCard({
    required this.icon,
    required this.title,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.accent, size: 34),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  const StatItem({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.accent),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: AppColors.muted, fontSize: 12),
        ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    required this.icon,
    required this.value,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Icon(icon, color: AppColors.accent),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class PodiumCard extends StatelessWidget {
  const PodiumCard({
    required this.player,
    required this.height,
    this.first = false,
    super.key,
  });

  final Player player;
  final double height;
  final bool first;

  @override
  Widget build(BuildContext context) {
    final podiumColor = player.rank == 1
        ? AppColors.accent
        : player.rank == 2
        ? const Color(0xFFD1D5DB)
        : const Color(0xFFFB923C);

    return SizedBox(
      width: first ? 100 : 86,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: first ? 38 : 32,
                backgroundColor: AppColors.primary,
                child: Text(
                  player.avatar,
                  style: TextStyle(fontSize: first ? 38 : 30),
                ),
              ),
              Positioned(
                right: -4,
                top: -10,
                child: Icon(
                  Icons.workspace_premium,
                  color: podiumColor,
                  size: first ? 34 : 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            player.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: first ? 14 : 12,
            ),
          ),
          Text(
            '${player.xp} XP',
            style: const TextStyle(
              color: AppColors.accent,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: height,
            width: 76,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: podiumColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            child: Text(
              '#${player.rank}',
              style: const TextStyle(
                color: AppColors.background,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerRow extends StatelessWidget {
  const PlayerRow({required this.player, super.key});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: player.currentUser
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                )
              : null,
          color: player.currentUser ? null : AppColors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: player.currentUser ? AppColors.accent : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              child: Text(
                '#${player.rank}',
                style: TextStyle(
                  color: player.currentUser
                      ? AppColors.accent
                      : AppColors.muted,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.22),
              child: Text(player.avatar),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '${player.xp} XP',
                    style: TextStyle(
                      color: player.currentUser
                          ? AppColors.accent
                          : AppColors.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (player.currentUser)
              const Pill(
                label: 'VOCÊ',
                background: AppColors.accent,
                foreground: AppColors.background,
              ),
          ],
        ),
      ),
    );
  }
}

class BadgeTile extends StatelessWidget {
  const BadgeTile({required this.badge, super.key});

  final BadgeInfo badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: badge.unlocked
            ? const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
              )
            : null,
        color: badge.unlocked ? null : AppColors.card.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(badge.icon, style: const TextStyle(fontSize: 32)),
                  const SizedBox(height: 8),
                  Text(
                    badge.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!badge.unlocked)
            Center(
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: 0.82),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lock, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  const AchievementCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
    super.key,
  });

  final String icon;
  final String title;
  final String description;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            EmojiTile(emoji: icon),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              date,
              style: const TextStyle(color: AppColors.muted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizQuestion {
  const QuizQuestion(this.question, this.options, this.correct);

  final String question;
  final List<String> options;
  final int correct;
}

class VictoryResult {
  const VictoryResult({required this.correctAnswers, required this.total});

  final int correctAnswers;
  final int total;
}

class Player {
  const Player(
    this.rank,
    this.avatar,
    this.name,
    this.xp, {
    this.currentUser = false,
  });

  final int rank;
  final String avatar;
  final String name;
  final int xp;
  final bool currentUser;
}

class BadgeInfo {
  const BadgeInfo(this.icon, this.name, this.unlocked);

  final String icon;
  final String name;
  final bool unlocked;
}

class NavItem {
  const NavItem(this.id, this.icon, this.label, this.route);

  final String id;
  final IconData icon;
  final String label;
  final String route;
}

const heroAvatar = '🦸';
