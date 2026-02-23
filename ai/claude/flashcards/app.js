// Flashcard App JavaScript

let flashcards = [];
let currentIndex = 0;
let mode = null; // 'chinese' or 'english'

// DOM Elements
const menuScreen = document.getElementById('menu');
const flashcardScreen = document.getElementById('flashcard');
const totalCardsEl = document.getElementById('total-cards');
const currentNumEl = document.getElementById('current-num');
const totalNumEl = document.getElementById('total-num');
const cardElement = document.querySelector('.card');
const cardFrontText = document.getElementById('card-front-text');
const cardPinyin = document.getElementById('card-pinyin');
const cardEnglish = document.getElementById('card-english');
const btnReveal = document.getElementById('btn-reveal');
const btnNext = document.getElementById('btn-next');
const btnEnd = document.getElementById('btn-end');
const btnChinese = document.getElementById('btn-chinese');
const btnEnglish = document.getElementById('btn-english');

// Load flashcards from JSON
async function loadFlashcards() {
  try {
    const response = await fetch('data.json');
    flashcards = await response.json();
    totalCardsEl.textContent = flashcards.length;
  } catch (error) {
    console.error('Error loading flashcards:', error);
  }
}

// Shuffle array using Fisher-Yates algorithm
function shuffle(array) {
  const arr = [...array];
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

// Show a specific screen
function showScreen(screen) {
  menuScreen.classList.remove('active');
  flashcardScreen.classList.remove('active');
  screen.classList.add('active');
}

// Start a new session
function startSession(selectedMode) {
  mode = selectedMode;
  flashcards = shuffle(flashcards);
  currentIndex = 0;
  showScreen(flashcardScreen);
  displayCard();
  totalNumEl.textContent = flashcards.length;
}

// Display current card
function displayCard() {
  const card = flashcards[currentIndex];

  // Clear content and start flip-back animation
  if (mode === 'chinese') {
    cardFrontText.textContent = card.chinese;
  } else {
    cardFrontText.textContent = card.english;
  }
  // Update progress
  currentNumEl.textContent = currentIndex + 1;

  cardElement.classList.remove('flipped');
  btnReveal.classList.remove('hidden');
  btnNext.classList.add('hidden');

  // Wait for flip animation to complete (600ms matches CSS transition)
  setTimeout(() => {
    // Set content based on mode
    if (mode === 'chinese') {
      cardPinyin.textContent = card.pinyin;
      cardEnglish.textContent = card.english;
    } else {
      cardPinyin.textContent = card.pinyin;
      cardEnglish.textContent = card.chinese;
    }
  }, 600);
}

// Reveal answer (flip card)
function revealAnswer() {
  cardElement.classList.add('flipped');
  btnReveal.classList.add('hidden');
  btnNext.classList.remove('hidden');
}

// Go to next card
function nextCard() {
  currentIndex++;
  if (currentIndex >= flashcards.length) {
    currentIndex = 0; // Loop back to start
  }
  displayCard();
}

// End session and return to menu
function endSession() {
  showScreen(menuScreen);
}

// Event Listeners
btnChinese.addEventListener('click', () => startSession('chinese'));
btnEnglish.addEventListener('click', () => startSession('english'));
btnReveal.addEventListener('click', revealAnswer);
btnNext.addEventListener('click', nextCard);
btnEnd.addEventListener('click', endSession);

// Initialize
loadFlashcards();
