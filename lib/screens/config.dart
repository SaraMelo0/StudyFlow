import 'package:flutter/material.dart';

void main() {
  runApp(const StudyFlowApp());
}

class StudyFlowApp extends StatelessWidget {
  const StudyFlowApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C3AED)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const ConfiguracoesScreen(),
    );
  }
}

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});
  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final TextEditingController _focoDurationController = TextEditingController(
    text: '25',
  );
  final TextEditingController _intervalosCurtoController =
      TextEditingController(text: '5');
  final TextEditingController _intervaloLongoController = TextEditingController(
    text: '15',
  );
  final TextEditingController _sessaoController = TextEditingController(
    text: '4',
  );
  bool _ativarNotificacoes = true;
  bool _alertasSonoros = true;
  bool _lembretesMetas = false;
  final TextEditingController _horasEstudoController = TextEditingController(
    text: '120',
  );
  int _selectedIndex = 2;
  static const Color _primaryColor = Color(0xFF7C3AED);
  static const Color _orangeColor = Color(0xFFFF6B35);
  static const Color _bgColor = Color(0xFF0F0F1A);
  static const Color _cardColor = Color(0xFF1A1A2E);
  static const Color _inputColor = Color(0xFF16213E);
  static const Color _textPrimary = Colors.white;
  static const Color _textSecondary = Color(0xFF8B8BA7);
  static const Color _dividerColor = Color(0xFF2A2A3E);
  @override
  void dispose() {
    _focoDurationController.dispose();
    _intervalosCurtoController.dispose();
    _intervaloLongoController.dispose();
    _sessaoController.dispose();
    _horasEstudoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _bgColor,
        elevation: 0,
        leading: const BackButton(color: _textPrimary),
        title: const Text(
          'Configurações',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              icon: Icons.person_outline,
              iconColor: _primaryColor,
              title: 'Conta',
            ),
            const SizedBox(height: 12),
            _buildProfileCard(),
            const SizedBox(height: 8),
            _buildActionTile(
              icon: Icons.edit_outlined,
              iconColor: _primaryColor,
              title: 'Editar perfil',
              subtitle: 'Altere nome e email',
              onTap: () {},
            ),
            const SizedBox(height: 8),
            _buildActionTile(
              icon: Icons.lock_outline,
              iconColor: _primaryColor,
              title: 'Alterar senha',
              subtitle: 'Atualize sua senha de acesso',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(
              icon: Icons.timer_outlined,
              iconColor: _orangeColor,
              title: 'Timer Pomodoro',
            ),
            const SizedBox(height: 12),
            _buildInputField(
              label: 'Duração do foco (minutos)',
              controller: _focoDurationController,
            ),
            const SizedBox(height: 10),
            _buildInputField(
              label: 'Intervalo curto (minutos)',
              controller: _intervalosCurtoController,
            ),
            const SizedBox(height: 10),
            _buildInputField(
              label: 'Intervalo longo (minutos)',
              controller: _intervaloLongoController,
            ),
            const SizedBox(height: 10),
            _buildInputField(
              label: 'Sessão antes do intervalo longo',
              controller: _sessaoController,
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(
              icon: Icons.notifications_outlined,
              iconColor: _primaryColor,
              title: 'Notificações',
            ),
            const SizedBox(height: 12),
            _buildSwitchTile(
              title: 'Ativar notificações',
              subtitle: 'Receba lembretes de estudo',
              value: _ativarNotificacoes,
              onChanged: (val) => setState(() => _ativarNotificacoes = val),
            ),
            _buildDivider(),
            _buildSwitchTile(
              title: 'Alertas sonoros',
              subtitle: 'Sons ao finalizar sessões',
              value: _alertasSonoros,
              onChanged: (val) => setState(() => _alertasSonoros = val),
            ),
            _buildDivider(),
            _buildSwitchTile(
              title: 'Lembretes de metas',
              subtitle: 'Avisos de prazos próximos',
              value: _lembretesMetas,
              onChanged: (val) => setState(() => _lembretesMetas = val),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(
              icon: Icons.flag_outlined,
              iconColor: _orangeColor,
              title: 'Meta Diária',
            ),
            const SizedBox(height: 12),
            _buildInputFieldWithSuffix(
              label: 'Horas de estudo por dia',
              controller: _horasEstudoController,
              suffix: 'minutos',
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                _buildHorasEquivalente(),
                style: const TextStyle(color: _textSecondary, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader(
              icon: Icons.storage_outlined,
              iconColor: _orangeColor,
              title: 'Gerenciamento de Dados',
            ),
            const SizedBox(height: 12),
            _buildActionTile(
              icon: Icons.bar_chart_outlined,
              iconColor: _primaryColor,
              title: 'Gerenciar sessões',
              subtitle: 'Ver e excluir sessões de estudo',
              onTap: () {},
            ),
            const SizedBox(height: 8),
            _buildActionTile(
              icon: Icons.refresh_outlined,
              iconColor: _primaryColor,
              title: 'Restaurar configurações',
              subtitle: 'Volta para o padrão',
              onTap: () => _showRestaurarDialog(),
            ),
            const SizedBox(height: 8),
            _buildActionTile(
              icon: Icons.delete_outline,
              iconColor: Colors.redAccent,
              title: 'Apagar todos os dados',
              subtitle: 'Remove matrículas, sessões e metas',
              onTap: () => _showApagarDialog(),
              titleColor: Colors.redAccent,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required Color iconColor,
    required String title,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: _textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: _primaryColor.withOpacity(0.2),
            child: const Icon(Icons.person, color: _primaryColor, size: 28),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Junior Moura',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'juniormoura@email.com',
                style: TextStyle(color: _textSecondary, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? titleColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor ?? _textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(color: _textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _textSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: _textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: _inputColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: _textPrimary, fontSize: 14),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputFieldWithSuffix({
    required String label,
    required TextEditingController controller,
    required String suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: _textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: _inputColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: _textPrimary, fontSize: 14),
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              Text(
                suffix,
                style: const TextStyle(color: _textSecondary, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: _textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: _orangeColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: _dividerColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: _dividerColor, height: 1);
  }

  String _buildHorasEquivalente() {
    final int minutos = int.tryParse(_horasEstudoController.text) ?? 0;
    final double horas = minutos / 60;
    return 'Equivalente a ${horas.toStringAsFixed(1)} horas por dia';
  }

  Widget _buildBottomNav() {
    const icons = [
      Icons.home_outlined,
      Icons.book_outlined,
      Icons.timer_outlined,
      Icons.notifications_outlined,
      Icons.person_outline,
    ];
    return Container(
      decoration: BoxDecoration(
        color: _cardColor,
        border: Border(top: BorderSide(color: _dividerColor, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _primaryColor,
        unselectedItemColor: _textSecondary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: icons
            .map((icon) => BottomNavigationBarItem(icon: Icon(icon), label: ''))
            .toList(),
      ),
    );
  }

  void _showRestaurarDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _cardColor,
        title: const Text(
          'Restaurar configurações',
          style: TextStyle(color: _textPrimary),
        ),
        content: const Text(
          'Deseja voltar todas as configurações para o padrão?',
          style: TextStyle(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: _textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _focoDurationController.text = '25';
                _intervalosCurtoController.text = '5';
                _intervaloLongoController.text = '15';
                _sessaoController.text = '4';
                _ativarNotificacoes = true;
                _alertasSonoros = true;
                _lembretesMetas = false;
                _horasEstudoController.text = '120';
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Restaurar',
              style: TextStyle(color: _primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showApagarDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _cardColor,
        title: const Text(
          'Apagar todos os dados',
          style: TextStyle(color: Colors.redAccent),
        ),
        content: const Text(
          'Esta ação é irreversível. Todos os dados serão removidos permanentemente.',
          style: TextStyle(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: _textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Apagar',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
