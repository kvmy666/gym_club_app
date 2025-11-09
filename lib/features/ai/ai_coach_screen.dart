import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import '../../core/theme/motion.dart';

class AiCoachScreen extends StatefulWidget {
  const AiCoachScreen({super.key});

  @override
  State<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends State<AiCoachScreen>
    with SingleTickerProviderStateMixin {
  final messages = <_AiMessage>[
    const _AiMessage(
      role: MessageRole.assistant,
      text: 'Welcome back! Ready for today\'s push workout?',
    ),
    const _AiMessage(
      role: MessageRole.user,
      text: 'Yes, but keep it light. Shoulders feel tight.',
    ),
    const _AiMessage(
      role: MessageRole.assistant,
      text:
          'Noted. Adding extra mobility work and lowering barbell load by 10%. Want a timer?',
    ),
  ];

  final TextEditingController controller = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _sendMessage(String value) {
    if (value.trim().isEmpty) return;
    final text = value.trim();
    controller.clear();
    final index = messages.length;
    setState(() {
      messages.add(_AiMessage(role: MessageRole.user, text: text));
    });
    _listKey.currentState?.insertItem(index, duration: AppMotion.cardEntrance);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      final replyIndex = messages.length;
      setState(() {
        messages.add(
          _AiMessage(
            role: MessageRole.assistant,
            text:
                'Got it. Logging the note for today and adjusting your nutrition macros.',
          ),
        );
      });
      _listKey.currentState?.insertItem(
        replyIndex,
        duration: AppMotion.cardEntrance,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.aiCoachTitle,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.aiCoachSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: theme.colorScheme.primaryContainer.withValues(
                        alpha: 0.7,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.hub, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.aiMicroserviceHint,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                initialItemCount: messages.length,
                itemBuilder: (context, index, animation) {
                  final msg = messages[index];
                  return SizeTransition(
                    sizeFactor: CurvedAnimation(
                      parent: animation,
                      curve: AppMotion.easeOut,
                    ),
                    child: _MessageBubble(message: msg),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: theme.brightness == Brightness.dark ? 0.4 : 0.12,
                      ),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: l10n.aiCoachInputHint,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                        ),
                        onSubmitted: _sendMessage,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: IconButton.filled(
                        onPressed: () => _sendMessage(controller.text),
                        icon: const Icon(Icons.send_rounded),
                      ),
                    ),
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

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final _AiMessage message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.role == MessageRole.user;
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = isUser
        ? theme.colorScheme.primary
        : theme.colorScheme.surface;
    final textColor = isUser ? Colors.white : theme.colorScheme.onSurface;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 6),
            bottomRight: Radius.circular(isUser ? 6 : 20),
          ),
          boxShadow: [
            if (!isUser)
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: theme.brightness == Brightness.dark ? 0.3 : 0.1,
                ),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Text(
          message.text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: textColor,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

enum MessageRole { user, assistant }

class _AiMessage {
  const _AiMessage({required this.role, required this.text});

  final MessageRole role;
  final String text;
}
