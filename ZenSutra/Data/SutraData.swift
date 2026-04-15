import Foundation

struct Sutra: Identifiable {
    let id = UUID()
    let title: String
    let tradition: String
    let verse: String
    let meaning: String
    let practice: String
}

struct BreathPattern: Identifiable {
    let id = UUID()
    let name: String
    let inhale: Int
    let hold: Int
    let exhale: Int
    let holdOut: Int
    let description: String
    let benefit: String
}

enum SutraData {
    static let sutras: [Sutra] = [
        Sutra(
            title: "Heart Sutra",
            tradition: "Mahayana Buddhism",
            verse: "Form is emptiness, emptiness is form.",
            meaning: "All phenomena lack inherent existence. What appears solid is in truth empty of independent being, yet this emptiness is not nothingness — it is the very ground from which all forms arise.",
            practice: "Sit quietly and observe how thoughts arise and dissolve, like clouds in a clear sky."
        ),
        Sutra(
            title: "Yoga Sutra I.2",
            tradition: "Patanjali's Yoga",
            verse: "Yogas citta vritti nirodhah.",
            meaning: "Yoga is the cessation of the fluctuations of the mind. When the mind becomes still, the seer abides in their own true nature.",
            practice: "Notice each thought without grasping. Let thoughts pass like leaves on a stream."
        ),
        Sutra(
            title: "Dhammapada 1",
            tradition: "Theravada Buddhism",
            verse: "Mind is the forerunner of all actions. If one speaks or acts with a pure mind, happiness follows like a shadow that never departs.",
            meaning: "Our inner state shapes our reality. A mind purified through practice naturally gives rise to wholesome speech and action, which in turn creates genuine wellbeing.",
            practice: "Before speaking today, pause and examine the intention behind your words."
        ),
        Sutra(
            title: "Tao Te Ching, Chapter 16",
            tradition: "Taoism",
            verse: "Return to the root is called stillness. Stillness is called returning to one's destiny.",
            meaning: "All things arise from stillness and return to it. By cultivating inner quiet, we align with the fundamental nature of existence.",
            practice: "Rest in awareness without doing. Allow the mind to settle like sediment in still water."
        ),
        Sutra(
            title: "Zen Koan",
            tradition: "Rinzai Zen",
            verse: "What was your original face before your parents were born?",
            meaning: "This koan points to the nature of the true self that exists prior to all conditioning, concepts, and identity. It cannot be answered intellectually — only realized directly.",
            practice: "Carry this question in your heart throughout the day without seeking an answer."
        ),
        Sutra(
            title: "Mandukya Upanishad",
            tradition: "Advaita Vedanta",
            verse: "Om — this whole world is om. What has been, what is, and what shall be — all this is om.",
            meaning: "The primordial sound Om is the vibration underlying all existence. Past, present, and future arise within consciousness, which itself is beyond time.",
            practice: "Chant Om three times and then sit in the silence that follows."
        ),
        Sutra(
            title: "Platform Sutra",
            tradition: "Chan Buddhism",
            verse: "The mind is originally pure. Use this mind directly — you are already Buddha.",
            meaning: "Enlightenment is not something to be attained in the future. The awakened nature is the very awareness reading these words right now.",
            practice: "Rest as pure awareness, recognizing thoughts as movements within that awareness."
        ),
        Sutra(
            title: "Ashtavakra Gita 1.3",
            tradition: "Advaita Vedanta",
            verse: "You are not bound by anything. What does pure consciousness have to do with purification?",
            meaning: "The true self is already free and pure. Only the mistaken identification with the body and mind creates the illusion of bondage.",
            practice: "Ask: Who is aware of my thoughts? Rest as that awareness."
        ),
        Sutra(
            title: "Zen Saying",
            tradition: "Soto Zen",
            verse: "Before enlightenment, chop wood, carry water. After enlightenment, chop wood, carry water.",
            meaning: "Awakening does not remove us from ordinary life — it transforms how we meet it. The activities remain the same; the one performing them is fundamentally changed.",
            practice: "Perform one ordinary task today with complete, undivided attention."
        ),
        Sutra(
            title: "Shiva Sutras I.1",
            tradition: "Kashmir Shaivism",
            verse: "Caitanyam atma — Consciousness is the Self.",
            meaning: "The fundamental nature of the individual self is pure, unlimited consciousness — identical with universal consciousness. Recognizing this is liberation.",
            practice: "Notice that you are always already aware. This awareness is your true nature."
        ),
    ]

    static let breathPatterns: [BreathPattern] = [
        BreathPattern(
            name: "4-7-8 Relaxing Breath",
            inhale: 4,
            hold: 7,
            exhale: 8,
            holdOut: 0,
            description: "Inhale for 4 counts, hold for 7, exhale slowly for 8. The extended exhale activates the parasympathetic nervous system.",
            benefit: "Deep relaxation, anxiety relief, sleep preparation"
        ),
        BreathPattern(
            name: "Box Breathing",
            inhale: 4,
            hold: 4,
            exhale: 4,
            holdOut: 4,
            description: "Equal counts of inhale, hold, exhale, and hold out. Used by Navy SEALs and first responders to maintain calm under pressure.",
            benefit: "Stress reduction, focus, emotional regulation"
        ),
        BreathPattern(
            name: "Natural Breath",
            inhale: 5,
            hold: 0,
            exhale: 5,
            holdOut: 0,
            description: "Simple, natural breathing with equal inhale and exhale. Brings awareness to the breath without manipulation.",
            benefit: "Mindfulness, centering, beginning meditation"
        ),
        BreathPattern(
            name: "Coherent Breathing",
            inhale: 5,
            hold: 0,
            exhale: 5,
            holdOut: 0,
            description: "Breathing at approximately 5 breaths per minute synchronizes heart rate variability and promotes calm alertness.",
            benefit: "HRV improvement, calm focus, cardiovascular health"
        ),
        BreathPattern(
            name: "2-1-4-1 Meditation",
            inhale: 2,
            hold: 1,
            exhale: 4,
            holdOut: 1,
            description: "A gentle pattern with extended exhale for meditation. The longer exhale settles the nervous system into receptive awareness.",
            benefit: "Meditation preparation, calming racing thoughts"
        ),
    ]
}
