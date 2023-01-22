import React from "react";
import { Link } from "react-router-dom";

// Assets
import BlockchainCredentialsImage from "../Images/blockchain_credentials.png";

// External Components
import {
  Paper,
  Grid,
  Box,
  Button,
  useMediaQuery,
  Typography,
} from "@material-ui/core";
import { makeStyles, useTheme } from "@material-ui/core/styles";

const useStyles = makeStyles((theme) => ({
  root: {
    height: "calc(100vh - 64px)",
    background: "rgba(128,0,32)",
    background:
      "linear-gradient(124deg, rgba(116,65,249,1) 0%, rgba(128,0,32) 36%, rgba(128,0,32) 100%)",

    overflow: "hidden",
  },
  paper: {
    padding: theme.spacing(2),
    textAlign: "center",
    color: theme.palette.text.secondary,
  },
  leftPanel: {
    paddingLeft: "10vw",
    paddingRight: "10vw",
    color: "white",
  },
}));

function Home() {
  const classes = useStyles();
  const theme = useTheme();
  const md = useMediaQuery(theme.breakpoints.up("md"));
  return (
    <>
      <Grid container className={classes.root}>
        <Grid item xs={12} md={6}>
          <Box
            style={{ height: "100%" }}
            display="flex"
            flexDirection="column"
            justifyContent="center"
            className={classes.leftPanel}
          >
            <Box
              style={{
                fontSize: "30px",
                fontWeight: "100",
              }}
            >
              Unlock the power of decentralized certificates
            </Box>
            <Box m={0.5} />
            <Box style={{ fontSize: "55px", fontWeight: "800" }}>
              SkillChain
            </Box>
            <Box m={1.5} />
            <Typography variant="body2">
              A decentralized system designed for institutes and colleges used for issuing and verifying certificates that
              are not mutable, protected by cryptography, and always available,
              all utilizing Ethereum smart contracts. With SkillChain, you can also revoke certificates and employers can confirm the credibility of each cetificate.{" "}
            </Typography>
            <Box m={1.5} />
            <Typography variant="h6">What do you want to do?</Typography>
            <Box m={1.5} />
            <Box display="flex">
              <Button
                variant="contained"
                color="primary"
                size="large"
                style={{ marginRight: "30px", fontWeight: "600" }}
                component={Link}
                to="/institute"
              >
                Issue Certificates
              </Button>
              <Button
                variant="contained"
                color="default"
                size="large"
                style={{ backgroundColor: "white", fontWeight: "600" }}
                component={Link}
                to="/view"
              >
                See Certificates
              </Button>
            </Box>
          </Box>
        </Grid>
        {md && (
          <Grid item xs={12} md={6}>
            <Box style={{ height: "100%" }} display="flex" alignItems=" center">
              <img src={BlockchainCredentialsImage} style={{ height: "85%" }} />
            </Box>
          </Grid>
        )}
      </Grid>
    </>
  );
}
export default Home;
