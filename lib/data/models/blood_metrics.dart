class BloodMetrics {
  const BloodMetrics({
    required this.rbcLabel,
    required this.rbcValue,
    required this.wbcLabel,
    required this.wbcValue,
    required this.spo2Label,
    required this.spo2Value,
    required this.sugarLabel,
    required this.sugarValue,
    required this.sugarStatus,
    required this.bpLabel,
    required this.bpValue,
    required this.bpStatus,
  });

  final String rbcLabel;
  final String rbcValue;
  final String wbcLabel;
  final String wbcValue;
  final String spo2Label;
  final String spo2Value;
  final String sugarLabel;
  final String sugarValue;
  final String sugarStatus;
  final String bpLabel;
  final String bpValue;
  final String bpStatus;

  static const BloodMetrics current = BloodMetrics(
    rbcLabel: 'Red Blood Cell (RBC) Count',
    rbcValue: '4.8 million/µL',
    wbcLabel: 'White Blood Cell (WBC) Count',
    wbcValue: '6,500/µL',
    spo2Label: 'Blood Oxygen Saturation (SpO2)',
    spo2Value: '98%',
    sugarLabel: 'Blood Sugar',
    sugarValue: '80 mg/dL',
    sugarStatus: 'Normal',
    bpLabel: 'Blood Pressure',
    bpValue: '102 / 72 mmHg',
    bpStatus: 'Normal',
  );
}

class PhenotypeMetric {
  const PhenotypeMetric({
    required this.id,
    required this.title,
  });

  static const String organ = 'organ';
  static const String blood = 'blood';
  static const String hormone = 'hormone';

  final String id;
  final String title;

  static const List<PhenotypeMetric> catalog = [
    PhenotypeMetric(id: organ, title: 'Organ Metrics'),
    PhenotypeMetric(id: blood, title: 'Blood Metrics'),
    PhenotypeMetric(id: hormone, title: 'Hormone'),
  ];
}
