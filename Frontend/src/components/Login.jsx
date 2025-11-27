import React, {
  useCallback,
  useContext,
  useEffect,
  useRef,
  useState,
} from "react";
import { useNavigate } from "react-router-dom";
import { UserContext } from "../UserContext";
import { loginWithGoogle, loginWithPassword } from "../utils/api";
import "../Styles/Login.css";

const GOOGLE_CLIENT_ID = process.env.REACT_APP_GOOGLE_CLIENT_ID;

const Login = () => {
  const [errorMessage, setErrorMessage] = useState("");
  const [loading, setLoading] = useState(false);
  const [loginMethod, setLoginMethod] = useState("password"); // "google" or "password"
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const { setUser } = useContext(UserContext);
  const navigate = useNavigate();
  const buttonContainerRef = useRef(null);
  const [googleReady, setGoogleReady] = useState(false);
  const [showLogin, setShowLogin] = useState(false);

  useEffect(() => {
    const script = document.createElement("script");
    script.src = "https://accounts.google.com/gsi/client";
    script.async = true;
    script.defer = true;
    script.onload = () => setGoogleReady(true);
    script.onerror = () =>
      setErrorMessage("Unable to load Google authentication script.");
    document.body.appendChild(script);
    return () => {
      document.body.removeChild(script);
    };
  }, []);

  const handleGoogleCredentialResponse = useCallback(
    async ({ credential }) => {
      if (!credential) {
        setErrorMessage("Missing Google credential. Try again.");
        return;
      }

      setLoading(true);
      setErrorMessage("");

      try {
        const response = await loginWithGoogle(credential);

        // Store the JWT token from backend response (not the Google credential)
        setUser({
          ...response.data,
          token: response.data.token, // Use JWT token from backend
        });
        navigate("/domain");
      } catch (err) {
        const message =
          err?.response?.data || "Google authentication failed. Access denied.";
        setErrorMessage(message);
      } finally {
        setLoading(false);
      }
    },
    [navigate, setUser]
  );

  const handlePasswordLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    setErrorMessage("");

    try {
      const response = await loginWithPassword(email, password);
      setUser({
        ...response.data,
        token: response.data.token,
      });
      navigate("/domain");
    } catch (err) {
      const message =
        err?.response?.data || "Invalid email or password";
      setErrorMessage(message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!googleReady || !window.google || !buttonContainerRef.current) {
      return;
    }

    if (!GOOGLE_CLIENT_ID) {
      setErrorMessage(
        "Missing Google client ID. Set REACT_APP_GOOGLE_CLIENT_ID in your environment."
      );
      return;
    }

    window.google.accounts.id.initialize({
      client_id: GOOGLE_CLIENT_ID,
      callback: handleGoogleCredentialResponse,
    });

    window.google.accounts.id.renderButton(buttonContainerRef.current, {
      theme: "outline",
      size: "large",
      text: "signin_with",
      logo_alignment: "center",
      width: 250, // Reduced width to fit better and look centered
    });
  }, [googleReady, handleGoogleCredentialResponse, loginMethod]);

  useEffect(() => {
    console.log("Login Component Rendered. showLogin:", showLogin);
  }, [showLogin]);

  return (
    <>
      <div className={`login-page ${showLogin ? "blurred" : ""}`}></div>

      {!showLogin ? (
        <div className="welcome-section-final">
          <div className="welcome-content">
            <h1>Welcome to <br /><span>ACADEMIA ERP</span></h1>
            <p>KNOWLEDGE IS SUPREME</p>
            <button className="enter-btn" onClick={() => setShowLogin(true)}>
              Login to Portal <i className="fas fa-arrow-right"></i>
            </button>
          </div>
        </div>
      ) : (
        <div className="login-container">
          <div className="login-header">
            <img
              src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
              alt="Profile"
              className="profile-icon"
            />
            <h2>ACADEMIA LOGIN</h2>
          </div>

          {/* Login Method Toggle */}
          <div className="login-tabs">
            <button
              className={`tab-btn ${loginMethod === "password" ? "active" : ""}`}
              onClick={() => setLoginMethod("password")}
            >
              Email/Password
            </button>
            <button
              className={`tab-btn ${loginMethod === "google" ? "active" : ""}`}
              onClick={() => setLoginMethod("google")}
            >
              Login with Google
            </button>
          </div>

          <div className="login-form">
            {loginMethod === "password" ? (
              /* Password Login Form */
              <form onSubmit={handlePasswordLogin}>
                <input
                  type="email"
                  placeholder="Email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                  disabled={loading}
                />
                <input
                  type="password"
                  placeholder="Password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  disabled={loading}
                />
                <p className="helper-text">
                  Demo: Use any email from database with password: <strong>password123</strong>
                </p>
                <button type="submit" disabled={loading}>
                  {loading ? "Logging in..." : "Login"}
                </button>
              </form>
            ) : (
              /* Google OAuth */
              <div className="google-login-section">
                <p>Sign in with your Google account</p>
                {loading && <p className="loading-message">Authenticating...</p>}
                <div ref={buttonContainerRef}></div>
              </div>
            )}

            {errorMessage && <p className="error-message">{errorMessage}</p>}
          </div>

          <button className="back-to-welcome" onClick={() => setShowLogin(false)}>
            ← Back
          </button>
        </div>
      )}
    </>
  );
};

export default Login;
