const word = document.getElementById('word');
const query = document.getElementById('query');
const output = document.getElementById('output');

query.onclick = () => {
    fetch('/define', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            word: word.value
        })
    })
    .then(r => r.json())
    .then(words => {
        while (output.firstChild) {
            output.removeChild(output.firstChild);
        }
        if (words.length > 0) {
            words.forEach(word => {
                const li = document.createElement('li');
                li.textContent = word;
                output.appendChild(li);
            });
        } else {
            output.textContent = 'No results!';
        }
    });
};

word.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') {
        query.onclick();
    }
});
