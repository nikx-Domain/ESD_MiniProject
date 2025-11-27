import React, {
  useCallback,
  useContext,
  useEffect,
  useRef,
  useState,
} from "react";
import { useNavigate } from "react-router-dom";
import { UserContext } from "../UserContext";
import { loginWithGoogle } from "../utils/api";
import "../Styles/Login.css";

const GOOGLE_CLIENT_ID = process.env.REACT_APP_GOOGLE_CLIENT_ID;

const Login = () => {
  const [errorMessage, setErrorMessage] = useState("");
  const [loading, setLoading] = useState(false);
  const { setUser } = useContext(UserContext);
  const navigate = useNavigate();
  const buttonContainerRef = useRef(null);
  const [googleReady, setGoogleReady] = useState(false);

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

      setUser({
        ...response.data,
        token: credential,
      });
      navigate("/domain");
    } catch (err) {
      const message =
        err?.response?.data || "Google authentication failed. Access denied.";
      setErrorMessage(message);
    } finally {
      setLoading(false);
    }
  }, [navigate, setUser]);

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
      theme: "filled_blue",
      size: "large",
      width: "100%",
    });

    window.google.accounts.id.prompt();
  }, [googleReady, handleGoogleCredentialResponse]);

  return (
    <>
      <div className="login-page"></div>

      <div className="login-container">
        <div className="login-header">
          <img
            src="https://cdn-icons-png.flaticon.com/512/4832/4832939.png"
            alt="Profile Icon"
            className="profile-icon"
          />
          <h2>Student Login</h2>
        </div>

        <div className="login-form">
          <p>Sign in with your approved Google account to continue.</p>
          <div ref={buttonContainerRef} style={{ width: "100%" }} />
          {loading && <p className="loading-message">Completing sign-in…</p>}
        </div>
        {errorMessage && <p className="error-message">{errorMessage}</p>}
      </div>
    </>
  );
};

export default Login;
