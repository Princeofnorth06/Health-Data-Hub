# Assignment 2 Asset Map

All 38 provided files were preserved. Files were copied to semantic paths, then originals were removed from `assets/` root after hash verification. Design PDFs live under `assets/data/` and are **not** registered in `pubspec.yaml` (they are source documents, ~91 MB total).

No font, SVG, GIF, WEBP, JPG, or JSON files were present in the Assignment 2 asset folder.

## Mapping

| Original | New | Category | Purpose | Used by |
|---|---|---|---|---|
| bladder-organ.png | images/organs/bladder.png | organs | Bladder visual. Provided file is a 32×32 identical black PNG stub (same bytes as other organ stubs). Filename purpose kept; content not replaced. | Wellness / Genotype organwise UI |
| brain-organ.png | images/organs/brain.png | organs | Brain visual. Same 32×32 black stub as other organ files. | Wellness / Genotype organwise UI |
| female-reproductive-system.png | images/organs/female_reproductive_system.png | organs | Female reproductive system visual. Same 32×32 black stub. | Wellness / Genotype organwise UI |
| heart-organ.png | images/organs/heart.png | organs | Heart visual. Same 32×32 black stub. | Wellness / Genotype organwise UI |
| intestine-organ.png | images/organs/intestine.png | organs | Intestine visual. Same 32×32 black stub. | Wellness / Genotype organwise UI |
| kidney-organ.png | images/organs/kidney.png | organs | Kidney visual. Same 32×32 black stub. | Wellness / Genotype organwise UI |
| liver-organ.png | images/organs/liver.png | organs | Liver visual. Same 32×32 black stub. | Wellness / Genotype organwise UI |
| liver-organ-1.png | images/organs/liver_1.png | organs | Liver Figma variant. Byte-identical to `liver.png`; both kept. | Wellness / Genotype organwise UI |
| lungs-organ.png | images/organs/lungs.png | organs | Lungs visual. Same 32×32 black stub. | Wellness / Genotype organwise UI |
| spine-.png | images/organs/spine.png | organs | Spine visual. Same 32×32 black stub. | Wellness / Genotype organwise UI |
| stomach-organ.png | images/organs/stomach.png | organs | Stomach visual. Same 32×32 black stub. | Wellness / Genotype organwise UI |
| thymus-gland-organ.png | images/organs/thymus_gland.png | organs | Thymus gland visual. Same 32×32 black stub. | Wellness / Genotype organwise UI |
| layer.png | images/genotype/dna_helix.png | genotype | Vertical cyan DNA double-helix mesh (192×388). | Genotype/Phenotype screen (`dna_visual`) |
| layer (1).png | images/genotype/dna_helix_1.png | genotype | DNA helix variant (192×400). Visually similar to `dna_helix.png` but different hash/size; both kept. | Genotype/Phenotype screen (`dna_visual`) |
| Group 8.png | images/genotype/dna_hero.png | genotype | Tall DNA hero illustration with geometric overlay and glow orbs (1194×2618). | Genotype screen hero / background |
| Group 8-1.png | images/genotype/dna_hero_1.png | genotype | DNA hero variant (1194×2618). Different hash from `dna_hero.png`; both kept. | Genotype screen hero / background |
| Frame 1321314326.png | images/icons/metric_selector.png | icons | Dark UI selector: Organ Metrics / Blood Metrics / Hormone. | Shared/common UI (Phenotype metric dropdown) |
| 仪表盘.png | images/decorative/gauge_green.png | decorative | Circular neon-green gauge showing 76% (346×346). Original filename is Chinese for “dashboard/gauge”. | Wellness screen / Dopamine screen |
| 仪表盘 (1).png | images/decorative/gauge_yellow.png | decorative | Circular yellow/teal gauge showing 66% (346×346). Gauge variant; both kept. | Genotype screen score gauge |
| red-human-cell-blood_488220-24406 1.png | images/decorative/red_blood_cells.png | decorative | 3D red blood cells on black (334×188). | Phenotype / blood-metrics visual |
| Community Landing Page.png | images/mockups/wellness_heart_score.png | mockups | Full-screen Wellness SLC6A4 Heart Score design export (402×1011). | Wellness screen (design reference) |
| Personalized Nutrition & Fitness.png | images/mockups/wellness_overview.png | mockups | Full-screen Overall Wellness Score 73% design export (402×1594). | Wellness screen (design reference) |
| Personalized Nutrition & Fitness-1.png | images/mockups/genotype_dopamine.png | mockups | Full-screen Genotype Dopamine Score design export (402×2010). | Genotype + Dopamine screens (design reference) |
| Personalized Nutrition & Fitness-2.png | images/mockups/phenotype_blood_metrics.png | mockups | Full-screen Phenotype Blood Metrics design export with metric selector overlay (402×1988). | Genotype/Phenotype screen (design reference) |
| Personalized Nutrition & Fitness-3.png | images/mockups/genotype_organwise.png | mockups | Full-screen Genotype organwise strengths/weaknesses export (402×2010). | Genotype screen (design reference) |
| Personalized Nutrition & Fitness-4.png | images/mockups/genotype_slc6a4.png | mockups | Full-screen SLC6A4 genotype detail export (402×2010). | Genotype screen (design reference) |
| Personalized Nutrition & Fitness-5.png | images/mockups/genotype_hormone.png | mockups | Full-screen Hormone Regulation / Dopamine Score export (402×2010). | Genotype + Dopamine screens (design reference) |
| Personalized Nutrition & Fitness-6.png | images/mockups/genotype_gene_carousel.png | mockups | Full-screen gene carousel (SLC6A4/COMT/OXTR/MAOA) export (402×2010). | Genotype screen (design reference) |
| Personalized Nutrition & Fitness-7.png | images/mockups/phenotype_blood_quality.png | mockups | Full-screen Phenotype Overall Blood Quality export (402×1988). | Genotype/Phenotype screen (design reference) |
| Community Landing Page.pdf | data/wellness_heart_score.pdf | data | PDF source for Wellness Heart Score mockup. Not bundled in Flutter. | Wellness screen (design source) |
| Personalized Nutrition & Fitness.pdf | data/wellness_overview.pdf | data | PDF source for Wellness overview mockup. Not bundled in Flutter. | Wellness screen (design source) |
| Personalized Nutrition & Fitness-1.pdf | data/genotype_dopamine.pdf | data | PDF source for Genotype Dopamine mockup. Not bundled in Flutter. | Genotype + Dopamine screens (design source) |
| Personalized Nutrition & Fitness-2.pdf | data/phenotype_blood_metrics.pdf | data | PDF source for Phenotype Blood Metrics mockup. Not bundled in Flutter. | Genotype/Phenotype screen (design source) |
| Personalized Nutrition & Fitness-3.pdf | data/genotype_organwise.pdf | data | PDF source for Genotype organwise mockup. Not bundled in Flutter. | Genotype screen (design source) |
| Personalized Nutrition & Fitness-4.pdf | data/genotype_slc6a4.pdf | data | PDF source for SLC6A4 detail mockup. Not bundled in Flutter. | Genotype screen (design source) |
| Personalized Nutrition & Fitness-5.pdf | data/genotype_hormone.pdf | data | PDF source for Hormone Regulation mockup. Not bundled in Flutter. | Genotype + Dopamine screens (design source) |
| Personalized Nutrition & Fitness-6.pdf | data/genotype_gene_carousel.pdf | data | PDF source for gene carousel mockup. Not bundled in Flutter. | Genotype screen (design source) |
| Personalized Nutrition & Fitness-7.pdf | data/phenotype_blood_quality.pdf | data | PDF source for Phenotype Blood Quality mockup. Not bundled in Flutter. | Genotype/Phenotype screen (design source) |

## Ambiguous assets

| Original | Decision |
|---|---|
| bladder-organ.png, brain-organ.png, female-reproductive-system.png, heart-organ.png, intestine-organ.png, kidney-organ.png, liver-organ.png, liver-organ-1.png, lungs-organ.png, spine-.png, stomach-organ.png, thymus-gland-organ.png | **Purpose from filename; pixel content unclear.** All 12 files are identical 32×32 black PNGs (same SHA-256). Preserved as separate organ paths. Not replaced with invented organ art. |
| liver-organ.png vs liver-organ-1.png | Byte-identical. Both kept as `liver.png` and `liver_1.png` (possible Figma states/variants). |
| Group 8.png vs Group 8-1.png | Content inspected: both are DNA hero illustrations. Different hashes. Named `dna_hero.png` / `dna_hero_1.png`. |
| layer.png vs layer (1).png | Content inspected: both are DNA helix meshes. Different dimensions/hashes. Named `dna_helix.png` / `dna_helix_1.png`. |
| 仪表盘.png vs 仪表盘 (1).png | Content inspected: circular gauges (76% green vs 66% yellow). Named from visual content, not the Chinese filename alone. |
| Frame 1321314326.png | Content inspected: Organ/Blood/Hormone metric selector. Named `metric_selector.png`. |
| assets/images/backgrounds/ | No standalone background file was provided. Folder kept empty (`.gitkeep`). |
| assets/fonts/ | No font files were provided. Folder kept empty (`.gitkeep`). `app_text_styles.dart` was not switched to an external/Google font. |

## Notes

- Flutter UI code should reference `AppAssets.*` rather than raw path strings.
- Runtime image directories are registered in `pubspec.yaml`.
- `assets/data/*.pdf` are preserved design sources and are intentionally not listed under `flutter/assets`.
