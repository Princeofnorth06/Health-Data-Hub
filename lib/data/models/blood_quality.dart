import 'package:health_data_hub/data/models/wellness_data.dart';

class BloodQuality {
  const BloodQuality({
    required this.score,
    required this.title,
    required this.overviewTitle,
    required this.overviewSubtitle,
    required this.ranges,
    required this.metrics,
    required this.recommendationGroups,
    required this.tip,
  });

  final double score;
  final String title;
  final String overviewTitle;
  final String overviewSubtitle;
  final List<WellnessRange> ranges;
  final List<BloodMetricRow> metrics;
  final List<BloodRecommendationGroup> recommendationGroups;
  final String tip;

  static const BloodQuality current = BloodQuality(
    score: 73,
    title: 'Overall Blood Quality',
    overviewTitle: 'Blood Health Overview',
    overviewSubtitle:
        'A detailed look at key blood metrics influencing your energy, immunity, and overall well-being.',
    ranges: [
      WellnessRange(
        name: 'High',
        label: '80% – 100%',
        min: 80,
        max: 100,
        description:
            'You may naturally feel more motivated, focused, and reward-driven.',
      ),
      WellnessRange(
        name: 'Moderate',
        label: '50% – 79%',
        min: 50,
        max: 79,
        description:
            'You may benefit from lifestyle habits that help boost and stabilize dopamine levels.',
      ),
      WellnessRange(
        name: 'Low',
        label: 'Below 50%',
        min: 0,
        max: 49,
        description:
            'You may be prone to low motivation or mood dips; consistent routines and dopamine-supportive habits can help maintain balance.',
      ),
    ],
    metrics: [
      BloodMetricRow(
        name: 'Hemoglobin (Hb)',
        description:
            'Hemoglobin is a protein in red blood cells that carries oxygen throughout your body.',
        value: '14.5 g/dL',
        healthyRange: '13.5 - 17.5 g/dL',
        status: 'Optimal',
      ),
      BloodMetricRow(
        name: 'Glucose (Fasting)',
        description:
            'Blood sugar levels affect metabolism and energy. Well-regulated glucose helps prevent fatigue.',
        value: '88 mg/dL',
        healthyRange: '70 - 99 mg/dL',
        status: 'Optimal',
      ),
      BloodMetricRow(
        name: 'Platelet Count',
        description:
            'Platelets are essential for blood clotting and wound healing. Balanced levels prevent excessive bleeding or clotting issues.',
        value: '250,000/µL',
        healthyRange: '150,000-450,000/µL',
        status: 'Optimal',
      ),
      BloodMetricRow(
        name: 'WBC Count',
        description:
            'WBCs are the body\'s defense system, fighting infections and inflammation. A strong count ensures a resilient immune response.',
        value: '5,500/µL',
        healthyRange: '4,500-11,000/µL',
        status: 'Moderate',
      ),
      BloodMetricRow(
        name: 'LDL Cholesterol',
        description:
            '"Bad" cholesterol can build up in arteries, increasing heart disease risk. Maintaining healthy levels is key for cardiovascular health.',
        value: '50 mg/dL',
        healthyRange: '<100 mg/dL',
        status: 'Moderate',
      ),
      BloodMetricRow(
        name: 'Triglycerides',
        description:
            'These fats store unused calories for energy. Normal levels indicate good heart and metabolic health.',
        value: '20 mg/dL',
        healthyRange: '<150 mg/dL',
        status: 'Low',
      ),
    ],
    recommendationGroups: [
      BloodRecommendationGroup(
        title: 'Oxygen & Circulation',
        items: [
          BloodRecommendationItem(
            label: 'Hemoglobin & RBC (Normal)',
            body:
                'Eat iron-rich foods like spinach and lean meats, and stay hydrated.',
          ),
        ],
      ),
      BloodRecommendationGroup(
        title: 'Cardiovascular Health',
        items: [
          BloodRecommendationItem(
            label: 'LDL Cholesterol (Slightly Elevated)',
            body:
                'Reduce fried foods, increase fiber intake with oats and vegetables, and exercise regularly.',
          ),
          BloodRecommendationItem(
            label: 'Triglycerides (Normal)',
            body:
                'Maintain a balanced diet with healthy fats like nuts and avocados.',
          ),
        ],
      ),
      BloodRecommendationGroup(
        title: 'Blood Sugar & Metabolism',
        items: [
          BloodRecommendationItem(
            label: 'Glucose (Normal)',
            body:
                'Eat balanced meals and stay active to support stable blood sugar levels.',
          ),
        ],
      ),
      BloodRecommendationGroup(
        title: 'Immunity & Inflammation',
        items: [
          BloodRecommendationItem(
            label: 'WBC (Normal)',
            body:
                'Strengthen immunity with vitamin C from citrus fruits, zinc from nuts, and probiotics.',
          ),
        ],
      ),
      BloodRecommendationGroup(
        title: 'Blood Clotting & Recovery',
        items: [
          BloodRecommendationItem(
            label: 'Platelets (Normal)',
            body:
                'Support healthy clotting with leafy greens and vitamin K-rich foods.',
          ),
        ],
      ),
      BloodRecommendationGroup(
        title: 'Nutrient Absorption',
        items: [
          BloodRecommendationItem(
            label: 'Vitamin B12 & D (Normal)',
            body:
                'Maintain levels with lean meats, eggs, dairy, and daily sun exposure.',
          ),
        ],
      ),
    ],
    tip:
        'A balanced diet, regular exercise, and stress management can help maintain overall health.',
  );
}

class BloodMetricRow {
  const BloodMetricRow({
    required this.name,
    required this.description,
    required this.value,
    required this.healthyRange,
    required this.status,
  });

  final String name;
  final String description;
  final String value;
  final String healthyRange;
  final String status;
}

class BloodRecommendationGroup {
  const BloodRecommendationGroup({
    required this.title,
    required this.items,
  });

  final String title;
  final List<BloodRecommendationItem> items;
}

class BloodRecommendationItem {
  const BloodRecommendationItem({
    required this.label,
    required this.body,
  });

  final String label;
  final String body;
}
