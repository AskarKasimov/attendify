import 'package:attendify/features/scanning/domain/entities/ble_device.dart';
import 'package:attendify/features/scanning/presentation/bloc/scanning_bloc.dart';
import 'package:attendify/features/scanning/presentation/bloc/scanning_event.dart';
import 'package:attendify/features/scanning/presentation/bloc/scanning_state.dart';
import 'package:attendify/shared/di/injection_container.dart';
import 'package:attendify/shared/ui_kit/components/app_button.dart';
import 'package:attendify/shared/ui_kit/components/status_card.dart';
import 'package:attendify/shared/ui_kit/theme/app_colors.dart';
import 'package:attendify/shared/ui_kit/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScanningPage extends StatelessWidget {
  const ScanningPage({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider.value(
    value: sl<ScanningBloc>(),
    child: const ScanningView(),
  );
}

class ScanningView extends StatelessWidget {
  const ScanningView({super.key});

  @override
  Widget build(final BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    String? eventId;
    String? eventPin;
    if (extra is Map) {
      eventId = extra['eventId'] as String?;
      eventPin = extra['eventPin'] as String?;
    }
    if (eventId == null ||
        eventId.isEmpty ||
        eventPin == null ||
        eventPin.isEmpty) {
      throw ArgumentError(
        'eventId и eventPin должны быть переданы в ScanningPage через extra',
      );
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Поиск участников',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(eventId, eventPin),
            const SizedBox(height: 24),
            _buildScanButton(context, eventId, eventPin),
            const SizedBox(height: 24),
            Expanded(child: _buildResultsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(final String? eventId, final String? eventPin) => Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(
            Icons.bluetooth_searching,
            size: 48,
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Поиск других участников мероприятия',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                (eventId != null &&
                    eventId.isNotEmpty &&
                    eventPin != null &&
                    eventPin.isNotEmpty)
                ? Column(
                    children: [
                      Text(
                        'ID события: $eventId',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'PIN: $eventPin',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Text(
                    'Нет данных о событии',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        ],
      ),
    ),
  );

  Widget _buildScanButton(
    final BuildContext context,
    final String eventId,
    final String eventPin,
  ) => BlocBuilder<ScanningBloc, ScanningState>(
    builder: (final context, final state) {
      final isScanning = state is ScanningScanningState;

      return AppButton.primary(
        onPressed: isScanning
            ? null
            : () {
                context.read<ScanningBloc>().add(
                  StartScanningEvent(eventId: eventId, eventPin: eventPin),
                );
              },
        text: isScanning ? 'Поиск в процессе...' : 'Начать поиск',
        isFullWidth: true,
        isLoading: isScanning,
        icon: isScanning ? null : Icons.bluetooth_searching,
      );
    },
  );

  Widget _buildResultsList() => BlocBuilder<ScanningBloc, ScanningState>(
    builder: (final context, final state) {
      if (state is ScanningInitialState) {
        return const Center(
          child: StatusCard(
            icon: Icons.bluetooth_searching,
            title: 'Готов к поиску',
            subtitle: 'Нажмите "Начать поиск" чтобы найти других участников',
            iconColor: AppColors.textSecondary,
            titleColor: AppColors.textSecondary,
          ),
        );
      }

      if (state is ScanningScanningState) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Поиск участников...',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        );
      }

      if (state is ScanningSuccessState) {
        final devices = state.devices;

        if (devices.isEmpty) {
          return const Center(
            child: StatusCard(
              icon: Icons.person_off,
              title: 'Участники не найдены',
              subtitle: 'Убедитесь, что другие участники включили режим маячка',
              iconColor: AppColors.textSecondary,
              titleColor: AppColors.textSecondary,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Найдено участников: ${devices.length}',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (final context, final index) {
                  final device = devices[index];
                  final deviceName = device.name.isEmpty
                      ? 'Участник ${index + 1}'
                      : device.name;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: _getSignalColor(device.signalQuality),
                        radius: 24,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      title: Text(
                        deviceName,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Расстояние: ~${device.estimatedDistance.toStringAsFixed(1)}м',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.signal_cellular_alt,
                                  size: 16,
                                  color: _getSignalColor(device.signalQuality),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Сигнал: ${device.rssi} dBm (${device.signalQuality.name})',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _getSignalColor(
                            device.signalQuality,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.bluetooth,
                          color: _getSignalColor(device.signalQuality),
                          size: 24,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }

      if (state is ScanningErrorState) {
        return Center(
          child: Column(
            children: [
              StatusCard(
                icon: Icons.error,
                title: 'Ошибка поиска',
                subtitle: state.message,
                iconColor: AppColors.error,
                titleColor: AppColors.error,
                backgroundColor: AppColors.error.withValues(alpha: 0.05),
              ),
              const SizedBox(height: 16),
              AppButton.outline(
                onPressed: () {
                  context.read<ScanningBloc>().add(const ClearResultsEvent());
                },
                text: 'Попробовать снова',
                isFullWidth: true,
              ),
            ],
          ),
        );
      }

      // Fallback для неизвестного состояния
      return const Center(
        child: StatusCard(
          icon: Icons.help,
          title: 'Неизвестное состояние',
          subtitle: 'Что-то пошло не так',
          iconColor: AppColors.textSecondary,
          titleColor: AppColors.textSecondary,
        ),
      );
    },
  );

  Color _getSignalColor(final SignalQuality quality) {
    switch (quality) {
      case SignalQuality.excellent:
        return const Color(0xFF4CAF50); // Green
      case SignalQuality.good:
        return const Color(0xFF8BC34A); // Light Green
      case SignalQuality.fair:
        return const Color(0xFFFF9800); // Orange
      case SignalQuality.poor:
        return AppColors.error; // Red from app colors
    }
  }
}
