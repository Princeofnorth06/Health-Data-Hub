import 'package:health_data_hub/data/models/genetic_trait.dart';
import 'package:health_data_hub/data/models/hormone_data.dart';
import 'package:health_data_hub/data/models/wellness_data.dart';

class HealthData {
  HealthData._();

  static const WellnessData wellness = WellnessData(
    score: 73,
    genotypeScore: 73.34,
    label: 'Overall Wellness Score',
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
    suggestions: [
      'Regular exercise to support dopamine and cortisol regulation.',
      'Include protein and magnesium-rich foods for neurotransmitter support.',
      'Prioritize quality sleep for hormone balance.',
    ],
    recommendations: [
      'Stay active and include regular exercise',
      'Add magnesium and protein-rich foods to your diet',
      'Maintain consistent sleep patterns',
    ],
  );

  static const List<HormoneData> hormones = [
    HormoneData(
      name: 'Dopamine',
      level: 60,
      description: 'Strong motivation, focus, and reward processing',
    ),
    HormoneData(
      name: 'Serotonin',
      level: 10,
      description: 'Good emotional balance and mood stability',
    ),
    HormoneData(
      name: 'Cortisol',
      level: 100,
      description: 'Well-regulated stress response and resilience',
    ),
    HormoneData(
      name: 'Melatonin',
      level: 100,
      description: 'Good natural support for sleep-wake cycle',
    ),
    HormoneData(
      name: 'Oxytocin',
      level: 25,
      description: 'Strong capacity for trust, bonding, and connection',
    ),
  ];

  static const List<HormoneData> hormoneRegulation = [
    HormoneData(
      name: 'Dopamine',
      level: 76,
      subtitle: 'Motivation & Focus Hormone',
      interpretation:
          'Your dopamine genotype score of 76% indicates a '
          'moderately strong ability to produce and regulate '
          'dopamine, the neurotransmitter responsible for '
          'motivation, focus, and feelings of reward.\n\n'
          'A score in this range suggests that while your '
          'dopamine system generally supports good drive and '
          'mental clarity, you may occasionally experience dips '
          'in motivation or focus during prolonged stress or '
          'mental fatigue.\n\n'
          'Supporting your dopamine levels through balanced '
          'nutrition, regular physical activity, good sleep, and '
          'engaging in rewarding activities can help you maintain '
          'consistent energy and focus throughout the day.',
      about:
          'Dopamine influences motivation, focus, pleasure, learning, '
          'and mood regulation.',
      aboutVariations: [
        HormoneToneVariation(
          label: 'Casual',
          text:
              'Helps you stay motivated, focused, and feel good after '
              'achieving goals.',
        ),
        HormoneToneVariation(
          label: 'Scientific',
          text:
              'A neurotransmitter essential for motivation, attention, reward '
              'processing, and emotional balance.',
        ),
        HormoneToneVariation(
          label: 'Wellness-focused',
          text:
              'Drives motivation, focus, positivity, and the satisfaction of '
              'achieving goals.',
        ),
      ],
    ),
    HormoneData(
      name: 'Serotonin',
      level: 0,
    ),
    HormoneData(
      name: 'Cortisol',
      level: 0,
    ),
    HormoneData(
      name: 'Melatonin',
      level: 0,
    ),
    HormoneData(
      name: 'OXTR',
      level: 0,
      subtitle: 'Oxytocin Receptor Gene',
    ),
  ];

  static const List<GeneticTrait> geneticTraits = [];
}
