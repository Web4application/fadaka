import { useState } from 'react';

export default function AIFunctions() {
    const [prompt, setPrompt] = useState('');
    const [functionType, setFunctionType] = useState('');
    const [response, setResponse] = useState('');
    const [loading, setLoading] = useState(false); // Loading state
    const [error, setError] = useState(null); // Error state

    const handleSubmit = async (e) => {
        e.preventDefault();

        // Basic form validation
        if (!prompt || !functionType) {
            setError('Please enter a prompt and select a function type.');
            return;
        }

        setLoading(true);
        setError(null);

        try {
            const res = await fetch('/api/ai', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ prompt, functionType }),
            });

            if (!res.ok) {
                throw new Error('Network response was not ok');
            }

            const data = await res.json();
            setResponse(data.response);
        } catch (err) {
            setError(err.message);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div>
            <h1>AI Functions</h1>
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    value={prompt}
                    onChange={(e) => setPrompt(e.target.value)}
                    placeholder="Enter your prompt..."
                />
                <select value={functionType} onChange={(e) => setFunctionType(e.target.value)}>
                    <option value="">Select Function</option>
                    <option value="predictiveAnalytics">Predictive Analytics</option>
                    <option value="marketAnalysis">Market Analysis</option>
                    <option value="automatedTrading">Automated Trading</option>
                    <option value="fraudDetection">Fraud Detection</option>
                    <option value="sentimentAnalysis">Sentiment Analysis</option>
                </select>
                <button type="submit" disabled={loading}>Submit</button>
            </form>
            {error && <div style={{ color: 'red' }}>{error}</div>}
            {loading && <div>Loading...</div>}
            <div>
                <h2>Response:</h2>
                <p>{response}</p>
            </div>
        </div>
    );
}
